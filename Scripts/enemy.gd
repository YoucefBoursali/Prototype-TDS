extends CharacterBody2D
class_name Enemy

signal death

@onready var label: Label = $State
@onready var state_machine: Node = $StateMachine
@onready var health_component: HealthComponent = $HealthComponent
@onready var player := get_tree().get_first_node_in_group("Player")

@export var blood: PackedScene
@export var speed := 100.0
@export var chase_radius := 600.0
@export var chase_radius_limit := 200.0



func _ready() -> void:
	health_component.damaged.connect(BloodEffect.blood_effect.bind(self))

func _process(delta: float) -> void:
	label.text = "State: " + str(state_machine.current_state.name)
	var direction := global_position.direction_to(player.global_position)
	rotation = direction.angle()

func _on_death() -> void:
	death.emit()
	BloodEffect.blood_effect(self)
