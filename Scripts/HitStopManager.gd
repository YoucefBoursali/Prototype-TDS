extends Node

func time_freeze(time: float) -> void:
	Engine.time_scale = 0
	await get_tree().create_timer(time, true, false, true).timeout
	Engine.time_scale = 1
