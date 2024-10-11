extends PanelContainer

class_name InventoryDialog

@export var slot_scene: PackedScene

@onready var items_grid: ItemGrid = %ItemsGrid
@onready var item_menu: Panel = %ItemMenu
@onready var health: MarginContainer = %Health
@onready var max_health: MarginContainer = %MaxHealth
@onready var attack: MarginContainer = %Attack
@onready var crit_chance: MarginContainer = %CritChance
@onready var crit_damage: MarginContainer = %CritDamage
@onready var deffence: MarginContainer = %Deffence
@onready var speed: MarginContainer = %Speed

var player_inventory


func _ready() -> void:
	SignalBus.stats_updated.connect(stats_updated)
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


func stats_updated(player_stats: PlayerStats):
	max_health.set_value(str(player_stats.max_health))
	attack.set_value(str(player_stats.attack))
	crit_chance.set_value(Utils.transform_float_to_percent(player_stats.crit_chance))
	crit_damage.set_value(Utils.transform_float_to_percent(player_stats.crit_damage))
	speed.set_value(str(player_stats.speed))
	deffence.set_value(str(player_stats.deffence))


func _on_close_button_pressed() -> void:
	hide()


func open_inventory_item_menu(item: Item, mouse_global_position: Vector2) -> void:
	item_menu.start(item)
	item_menu.global_position = mouse_global_position
