extends CharacterBody2D
class_name Player

signal died

@export var player_data: PlayerData
@export var amount: float

@onready var health: PlayerHealth = $Health
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = %Sprite2D
@onready var gun: Gun = $Gun
@onready var camera: Camera2D = %Camera2D





func _ready() -> void:
	gun.shooting.connect(camera.camera_shake.bind(amount))
	health.damaged.connect(func():BloodEffect.blood_effect(self))

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left","right","up","down").normalized()
	if direction:
		velocity = direction * player_data.speed
	else:
		velocity = Vector2.ZERO
	if velocity.length() > 0:
		animation_player.play("Walk")
	else:
		animation_player.play("Idle")
	var rotating := global_position.direction_to(get_global_mouse_position()).angle() 
	rotation = rotating + PI/2
	move_and_slide()
func _on_health_health_depleted() -> void:
	died.emit()
	BloodEffect.blood_effect(self)
