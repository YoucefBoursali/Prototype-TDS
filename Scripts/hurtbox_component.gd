extends Area2D

class_name HurtboxComponent

@export var health_component: HealthComponent

func damage(damage: int):
	if health_component:
		health_component.take_damage(damage)
