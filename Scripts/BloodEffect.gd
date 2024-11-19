extends Node

@onready var blood: PackedScene = preload("res://Scenes/cpu_particles_2d.tscn")


func blood_effect(target: Node2D) -> void:
	var new_blood := blood.instantiate() as CPUParticles2D
	new_blood.emitting = true
	new_blood.global_position = target.global_position
	if is_instance_valid(Global.bullet):
		new_blood.rotation = Global.bullet.global_position.angle_to_point(target.global_position)
	get_tree().current_scene.add_child.call_deferred(new_blood)
