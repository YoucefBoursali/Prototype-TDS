extends State

var idle_timer: Timer

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	idle_timer = Timer.new()
	idle_timer.autostart = true
	idle_timer.wait_time = randi_range(1, 4)
	idle_timer.timeout.connect(_on_timeout)
	add_child(idle_timer)

func state_physics(delta: float) -> void:
	try_chase()

func _on_timeout() -> void:
	Transition.emit(self, "Wander")

func exit() -> void:
	idle_timer.queue_free()
