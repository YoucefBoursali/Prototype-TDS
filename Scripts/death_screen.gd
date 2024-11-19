extends Control

@export var length: float
@onready var color_rect: ColorRect = $ColorRect
@onready var panel_container: PanelContainer = $PanelContainer

func transition() -> void:
	await get_tree().process_frame
	get_tree().paused = true
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "modulate:a", 1, length)
	await tween.finished
	panel_container.visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
