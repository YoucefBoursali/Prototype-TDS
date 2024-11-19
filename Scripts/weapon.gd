extends Gun

@onready var player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	if bullet_resource.bullet_in_clip < bullet_resource.max_bullets:
		reload()
	shoot()


func shoot():
	direction = marker.global_position.direction_to(player.global_position)
	if !shootingcooldown.is_stopped():
		return
	spawn_bullets()
	ammo()
	shootingcooldown.start(1 - bullet_resource.fire_rate)


func spawn_bullets() -> void:
	if can_shoot:
		for bullet in bullet_resource.bullet_count:
			var new_bullet = bullets.instantiate()
			new_bullet.damage = bullet_resource.attack_damage
			new_bullet.speed = bullet_resource.bullet_speed
			new_bullet.global_position = marker.global_position
			if bullet_resource.bullet_count == 1:
				new_bullet.rotation = direction.angle()
			else:
				var angle_arc := deg_to_rad(bullet_resource.arc)
				var angle_gap := angle_arc/(bullet_resource.bullet_count -1)
				new_bullet.rotation =(direction.angle() + angle_gap * bullet - angle_arc/2)
			get_tree().current_scene.add_child(new_bullet)


func reload():
	if bullet_resource.bullet_in_clip <= 0:
		await get_tree().create_timer(2).timeout
		var current_ammo := bullet_resource.max_bullets - bullet_resource.bullet_in_clip
		bullet_resource.bullet_in_clip += bullet_resource.bullet_amount
		bullet_resource.bullet_amount -= current_ammo
		if bullet_resource.bullet_in_clip > 0:
			can_shoot = true
