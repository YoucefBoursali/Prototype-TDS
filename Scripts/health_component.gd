extends Node2D

class_name HealthComponent

signal health_changed
signal health_depleted
signal damaged
var HasDied: bool = false
var isDamaged: bool
@export var max_health: int:
	set(value):
		max_health = value
		if current_health > max_health:
			current_health = max_health
var current_health: int:
	set(value):
		current_health = value
		current_health = clamp(value, 0, max_health)
		health_changed.emit()
		isDamaged = true
		if !HasHealthRemaining() and !HasDied:
			HasDied = true
			health_depleted.emit()
		if isDamaged and !HasDied:
			damaged.emit()
func _ready() -> void:
	current_health = max_health
func HasHealthRemaining() -> bool:
	if current_health > 0:
		return true
	return false
func take_damage(damage: int) -> void:
	current_health -= damage
