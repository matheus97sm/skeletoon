extends PanelContainer

class_name InventoryDialog

@export var slot_scene: PackedScene

@onready var items_grid: ItemGrid = %ItemsGrid


func open(inventory: Inventory):
	if visible == true:
		hide()
		return
	
	show()
	
	items_grid.display(inventory.get_items())


func _on_close_button_pressed() -> void:
	hide()
