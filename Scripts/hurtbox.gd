extends Area2D
class_name Hurtbox
@export var player_health: PlayerHealth

func damage(damage: int):
	if player_health:
		player_health.take_damage(damage)
