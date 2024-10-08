extends CanvasLayer


@export var all_recipes: ResourceGroup

@onready var player: CharacterBody2D = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog
@onready var crafting_dialog: CraftingDialog = %CraftingDialog
@onready var player_interface: Panel = %PlayerInterface

var _all_recipes: Array[Recipe] = []
var _recipes_dir_name: String = "res://data/recipes/"


func _ready() -> void:
	all_recipes.load_all_into(_all_recipes)


func update_health(health: int, max_health: int):
	if player_interface:
		player_interface.set_health(health, max_health)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("open_inventory"):
		inventory_dialog.open(player.inventory)
	
	if event.is_action_released("open_crafting"):
		crafting_dialog.open(_all_recipes, player.inventory)


func _on_player_update_health(health: int, max_health: int) -> void:
	update_health(health, max_health)
