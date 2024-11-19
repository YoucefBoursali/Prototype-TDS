extends State

var knock_timer: Timer
@export var knockback_force := 0.8
var accel := 0.2

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	knock_timer = Timer.new()
	knock_timer.autostart = true
	knock_timer.wait_time = 0.4
	knock_timer.timeout.connect(_on_timeout)
	add_child(knock_timer)
func state_physics(delta: float) -> void:

	var knockback_direction := enemy.global_position - player.global_position
	enemy.velocity = enemy.velocity.lerp(knockback_direction * knockback_force, accel)
	enemy.move_and_slide()


func _on_timeout() -> void:
	Transition.emit(self, "Fellow")

func exit() -> void:
	knock_timer.queue_free() 
