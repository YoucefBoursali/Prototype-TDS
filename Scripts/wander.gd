extends State

var direction: Vector2
var wander_timer: Timer

func enter() -> void:
	direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	enemy.velocity = direction * enemy.speed
	wander_timer = Timer.new()
	wander_timer.autostart = true
	wander_timer.wait_time = randi_range(1,6)
	wander_timer.timeout.connect(_on_timeout)
	add_child(wander_timer)
func _on_timeout() -> void:
	Transition.emit(self, "Idle")

func state_physics(delta: float) -> void:
	var collision = enemy.move_and_collide(enemy.velocity * delta)
	if collision:
		enemy.velocity = enemy.velocity.bounce(collision.get_normal())
	try_chase()
func exit() -> void:
	wander_timer.queue_free()
