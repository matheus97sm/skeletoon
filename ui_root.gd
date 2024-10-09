extends CanvasLayer


@export var all_recipes: ResourceGroup

@onready var player: CharacterBody2D = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog
@onready var crafting_dialog: CraftingDialog = %CraftingDialog

var _all_recipes: Array[Recipe] = []
var _recipes_dir_name: String = "res://data/recipes/"


func _ready() -> void:
	all_recipes.load_all_into(_all_recipes)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("open_inventory"):
		inventory_dialog.open(player.inventory)
	
	if event.is_action_released("open_crafting"):
		crafting_dialog.open(_all_recipes, player.inventory)
		
	if event.is_action_released("close_dialogs"):
		for i in range(get_children().size()):
			var actual_gui = get_children().size() - i - 1
			
			if actual_gui == 0:
				return
			
			if get_child(actual_gui).visible:
				get_child(actual_gui).hide()
				return
