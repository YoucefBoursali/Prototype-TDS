extends Node2D
class_name PlayerHealth

signal health_depleted
signal damaged

var HasDied: bool = false
var isDamaged: bool = false


@export var max_health: int:
	set(value):
		max_health = value
		Global.player_max_health =max_health
		if current_health > max_health:
			current_health = max_health
var current_health: int:
	set(value):
		current_health = value
		current_health = clamp(value, 0, max_health)
		Global.player_health = current_health
		isDamaged = true
		SignalBus.update_health_ui.emit(Global.player_health, Global.player_max_health)
		if !HasHealthRemaining() and !HasDied:
			HasDied = true
			health_depleted.emit()


func _ready() -> void:
	current_health = max_health
	Global.player_health = current_health
	Global.player_max_health = max_health
func HasHealthRemaining() -> bool:
	if current_health > 0:
		return true
	return false

func take_damage(damage: int) -> void:
	current_health -= damage
	damaged.emit()
func heal():
	pass
