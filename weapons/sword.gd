extends Area2D


func _on_area_entered(area: Area2D) -> void:
	print("Area entered")
	if area.has_method("take_damage"):
		area.take_damage()
