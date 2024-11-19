extends TextureRect

func _drop_data(at_position: Vector2, data: Variant) -> void:
	texture = data

func _get_drag_data(at_position: Vector2) -> Variant:
	var texture_preview = TextureRect.new()
	texture_preview.texture = texture
	texture_preview.expand_mode = 1
	texture_preview.size = Vector2(30,30)
	
	var control = Control.new()
	control.add_child(texture_preview)
	set_drag_preview(control)
	texture = null
	return texture_preview.texture

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Texture2D
