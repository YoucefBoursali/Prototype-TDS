extends State

@export var chase_speed := 170.0
func state_physics(delta: float) -> void:
	var direction := (player.global_position - enemy.global_position)
	var distance = direction.length()
	if distance > enemy.chase_radius:
		Transition.emit(self, "Idle") 
		return
	enemy.velocity = direction.normalized() * chase_speed
	if distance <= enemy.chase_radius_limit:
		enemy.velocity = Vector2.ZERO
	enemy.move_and_slide()
