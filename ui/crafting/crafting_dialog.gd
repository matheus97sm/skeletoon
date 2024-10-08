extends PanelContainer

class_name CraftingDialog

@export var slot_scene: PackedScene

@onready var recipes_list: ItemList = %RecipesList
@onready var ingredients_container: ItemGrid = %IngredientsContainer
@onready var results_container: ItemGrid = %ResultsContainer
@onready var craft_button: Button = %CraftButton

var _inventory: Inventory
var _selected_recipe: Recipe

func open(recipes: Array[Recipe], inventory: Inventory):
	_inventory = inventory
	
	if visible == true:
		hide()
		return
	
	show()
	
	recipes_list.clear()
	for recipe in recipes:
		var index = recipes_list.add_item(recipe.name)
		recipes_list.set_item_metadata(index, recipe)
	
	recipes_list.select(0)
	_on_recipes_list_item_selected(0)

func _on_close_button_pressed() -> void:
	hide()


func _on_recipes_list_item_selected(index: int) -> void:
	_selected_recipe = recipes_list.get_item_metadata(index)
	ingredients_container.display(_selected_recipe.ingredients)
	results_container.display(_selected_recipe.results)
	
	craft_button.disabled = not _inventory.has_all(_selected_recipe.ingredients)


func _on_craft_button_pressed() -> void:
	for item in _selected_recipe.ingredients:
		_inventory.remove_item(item)
	
	for item in _selected_recipe.results:
		_inventory.add_item(item)
	
	craft_button.disabled = not _inventory.has_all(_selected_recipe.ingredients)
