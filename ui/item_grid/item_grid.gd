extends GridContainer

class_name ItemGrid


@export var slot_scene: PackedScene


func display(items: Array[Item]):	
	for child in get_children():
		child.queue_free()
	
	for item in items:
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display_item(item)
