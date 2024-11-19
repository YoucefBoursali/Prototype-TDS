extends Node
class_name State

signal Transition(new_state: State, new_state_name: String)

var player: Player

@onready var enemy: Enemy = get_owner()

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	enemy.death.connect(die)

func enter() -> void:
	pass

func exit() -> void:
	pass

func state_process(delta: float) -> void:
	pass

func state_physics(delta: float) -> void:
	pass 

func try_chase() -> bool:
	var distance = enemy.global_position.distance_to(player.global_position)
	if distance <= enemy.chase_radius:
		Transition.emit(self, "Fellow")
		return true
	return false

func die() -> void:
	Transition.emit(self, "Death")
