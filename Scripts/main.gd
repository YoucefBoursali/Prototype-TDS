extends Node2D
@onready var death_screen: Control = $UI/DeathScreen
@onready var player: Player = %Player
@onready var ui: CanvasLayer = $UI
var mouse_cursor := load("res://Assets/mouse.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(mouse_cursor)
	player.died.connect(death_screen.transition)
