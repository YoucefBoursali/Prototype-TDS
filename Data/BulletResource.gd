extends Resource
class_name BulletResource

@export var texture: Texture2D

@export var bullet_count := 1
@export var arc := 0
@export var fire_rate: float
@export var attack_damage := 3.0
@export var bullet_speed := 600.0
@export var max_bullets := 12
@export var bullet_amount: int:
	set(value):
		bullet_amount = value
		if bullet_amount <= 0:
			bullet_amount = 0
var bullet_in_clip: int:
	set(value):
		bullet_in_clip = value
		bullet_in_clip = clamp(value,0, max_bullets)
