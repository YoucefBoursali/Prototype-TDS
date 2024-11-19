extends CharacterBody2D
class_name Bullet

@export var bullet_resource: BulletResource

var damage: float 
var speed: float 
var direction: Vector2

func _enter_tree() -> void:
	Global.bullet = self

func _exit_tree() -> void:
	Global.bullet = null

func _physics_process(delta: float) -> void:
	direction = Vector2.RIGHT.rotated(rotation)
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		area.damage(damage)
		queue_free()
