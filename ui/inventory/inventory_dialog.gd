extends PanelContainer

class_name InventoryDialog

@export var slot_scene: PackedScene

@onready var items_grid: ItemGrid = %ItemsGrid

var player_inventory


func _ready() -> void:
	SignalBus.inventory_updated.connect(update)


func open(inventory: Inventory):
	if visible == true:
		hide()
		return
	
	show()
	
	items_grid.display(inventory.get_items())
	player_inventory = inventory


func update():
	if player_inventory:
		items_grid.display(player_inventory.get_items())


func _on_close_button_pressed() -> void:
	hide()
