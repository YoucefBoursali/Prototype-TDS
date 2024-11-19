extends Bullet


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.damage(damage)
		queue_free()
