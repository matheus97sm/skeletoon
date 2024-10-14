extends TextureRect


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview = TextureRect.new()
	preview.texture = texture
	set_drag_preview(preview)
	
	return owner
