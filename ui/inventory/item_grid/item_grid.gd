class_name ItemGrid extends GridContainer


@export var slot_scene: PackedScene


func display(items: Array[Item]):
	for child in get_children():
		child.queue_free()
	
	var store_position = 0
	
	for item in items:
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display_item(item, store_position)
		store_position += 1
