extends Node

var current_state: State
@export var initial_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(_on_transitioning)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_physics(delta)

func _process(delta: float) -> void:
	if current_state:
		current_state.state_process(delta)

func _on_transitioning(state: State, new_state_name: String):
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state: 
		return
	if current_state:
		current_state.exit()
	current_state = new_state
	new_state.enter()
