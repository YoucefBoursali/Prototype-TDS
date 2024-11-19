extends Node2D
class_name Gun

signal shooting



@export var bullets: PackedScene
@export var bullet_resource: BulletResource

@export var shootingcooldown: Timer
@export var marker: Marker2D 
@export var sprite: Sprite2D 

var direction: Vector2
var can_shoot: bool = true


func _ready() -> void:
	#sprite.texture = bullet_resource.texture
	bullet_resource.bullet_in_clip = bullet_resource.max_bullets
	SignalBus.update_ammo_ui.emit()



func _physics_process(delta: float) -> void:
	if bullet_resource.bullet_in_clip < bullet_resource.max_bullets:
		reload()
	shoot()
	SignalBus.update_ammo_ui.emit()
	Global.bullet_amount = bullet_resource.bullet_amount
	Global.bullet_in_clip = bullet_resource.bullet_in_clip


func shoot():
	direction = marker.global_position.direction_to(get_global_mouse_position())
	if !shootingcooldown.is_stopped():
		return
	
	if Input.is_action_pressed("shoot"):
		spawn_bullets()
		ammo()
		shootingcooldown.start(1 - bullet_resource.fire_rate)


func spawn_bullets() -> void:
	if can_shoot:
		for bullet in bullet_resource.bullet_count:
			var new_bullet = bullets.instantiate() as Bullet
			new_bullet.damage = bullet_resource.attack_damage
			new_bullet.speed = bullet_resource.bullet_speed
			new_bullet.global_position = marker.global_position
			if bullet_resource.bullet_count == 1:
				new_bullet.rotation = direction.angle()
			else:
				var angle_arc := deg_to_rad(bullet_resource.arc)
				var angle_gap := angle_arc/(bullet_resource.bullet_count -1)
				new_bullet.rotation =(direction.angle() + angle_gap * bullet - angle_arc/2)
			shooting.emit()
			get_tree().current_scene.add_child(new_bullet)
func ammo() -> void:
	bullet_resource.bullet_in_clip -= 1
	if bullet_resource.bullet_in_clip <= 0:
		can_shoot = false


func reload():
	if Input.is_action_just_pressed("reload"):
		var current_ammo := bullet_resource.max_bullets - bullet_resource.bullet_in_clip
		bullet_resource.bullet_in_clip += bullet_resource.bullet_amount
		bullet_resource.bullet_amount -= current_ammo
		if bullet_resource.bullet_in_clip > 0:
			can_shoot = true
