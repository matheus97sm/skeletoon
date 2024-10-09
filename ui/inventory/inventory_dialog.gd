extends PanelContainer

class_name InventoryDialog

@export var slot_scene: PackedScene

@onready var items_grid: ItemGrid = %ItemsGrid
@onready var item_menu: Panel = %ItemMenu

var player_inventory


func _ready() -> void:
	SignalBus.inventory_updated.connect(update)
	SignalBus.open_inventory_item_menu.connect(open_inventory_item_menu)


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


func open_inventory_item_menu(item: Item, mouse_global_position: Vector2) -> void:
	item_menu.start(item)
	item_menu.global_position = mouse_global_position
