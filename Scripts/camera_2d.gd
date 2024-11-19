#extends Camera2D
#
#var noise := FastNoiseLite.new()
#
#@export var decay := 0.5
#@export var amplitude := 5.0
#
#var trauma = 0.0
#var trauma_power = 2.0
#var noise_speed = 5.0
#var _noise_y = 0.0
#var max_roll := 0.1
 #
#func _ready() -> void:
	#randomize()
	#noise.seed = randi()
	#noise.noise_type = FastNoiseLite.TYPE_PERLIN
	#
#func _physics_process(delta: float) -> void:
	#if trauma > 0.0:
		#trauma = max(trauma - decay * delta, 0)
		#_noise_y += noise_speed
		#_shake()
#
#func add_trauma(amount: float) -> void:
	#trauma = min(trauma + amount, 1.0)
#
#func _shake() -> void:
	#var amount = pow(trauma, trauma_power)
	#rotation = max_roll * amount * randf_range(-1, 1)
	#offset.x = amplitude * amount * noise.get_noise_2d(noise.seed, _noise_y)
	#offset.y = amplitude * amount * noise.get_noise_2d(noise.seed * 2, _noise_y)
#
#func camera_shake() -> void:
	#add_trauma(0.2)
	

extends Camera2D

@export var decay : float = 2
const MAX_DISTANCE := 86
var cam_pos = position
@onready var player: Player = get_owner()

var max_offset = Vector2(100, 75)
var max_roll : float = 0.1
var speed := 100
var trauma : float = 0.0
var trauma_power : int = 2
var target_distance := 0
func _ready():
	randomize()

func add_trauma(amount: float) -> void:
	trauma = min(trauma + amount, 1.0)

func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	var direction := cam_pos.direction_to(get_local_mouse_position())
	var target_pos = cam_pos + direction * target_distance
	target_pos = target_pos.clamp(position - Vector2(MAX_DISTANCE, MAX_DISTANCE), position + Vector2(MAX_DISTANCE, MAX_DISTANCE))
	position = target_pos
	camera_smoothing()
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_smoothing()

func shake() -> void:
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)

func camera_shake(amount: float) -> void:
	add_trauma(amount)

func camera_smoothing():
	if Input.is_action_pressed("shift"):
		position_smoothing_enabled = true
		target_distance = cam_pos.distance_to(get_global_mouse_position())/2
	elif !Input.is_action_pressed("shift"):
		position_smoothing_enabled = false
		position = Vector2.ZERO
