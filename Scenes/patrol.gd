extends State

var points: Array = []
var temp_points: Array
var current_point: Marker2D
var direction: Vector2 = Vector2.ZERO
#
#func enter() -> void:
	#for marker in markers.get_children():
		#points.push_front(marker)
	#get_positions()
	#current_position()
#
#func state_physics(delta: float) -> void:
	#if enemy.global_position.distance_to(current_point.global_position) < 10:
		#current_position()
	#enemy.velocity = direction * 200
	#enemy.move_and_slide()
#
#func get_positions() -> void:
	#temp_points = points.duplicate()
#
#func current_position() -> void:
	#if temp_points.is_empty():
		#get_positions()
	#current_point = temp_points.pop_front()
	#direction = (current_point.position).normalized()
