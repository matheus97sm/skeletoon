extends Node

const DEFAULT_COLOR = "#FFF"
const CRITICAL_COLOR = "#B22"
const ZERO_DAMAGE_COLOR = "#FFF8"
const DEFAULT_FONT_SIZE = 24
const OUTLINE_COLOR = "#000"
const OUTLINE_SIZE = 1


func display_number(value: int, position: Vector2, is_critical: bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	number.label_settings.font = preload("res://fonts/Inconsolata-Black.ttf")
	
	var color = DEFAULT_COLOR
	var font_size = DEFAULT_FONT_SIZE
	
	if is_critical:
		color = CRITICAL_COLOR
		font_size = 30
	
	if value == 0:
		color = ZERO_DAMAGE_COLOR
		font_size = 18
	
	number.label_settings.font_color = color
	number.label_settings.font_size = font_size
	number.label_settings.outline_color = OUTLINE_COLOR
	number.label_settings.outline_size = OUTLINE_SIZE
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var random_y_direction = randf_range(20, 26)
	var random_x_direction = randf_range(-15, 15)
	
#	Animations
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - random_y_direction, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:x", number.position.x + random_x_direction, 0.65
	).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(
		number, "position:y", number.position.y + random_y_direction, 0.35
	).set_ease(Tween.EASE_IN_OUT).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.35
	).set_ease(Tween.EASE_IN_OUT).set_delay(0.25)
	
	await tween.finished
	number.queue_free()
