extends Panel

@onready var item_list: ItemList = $PanelContainer/MarginContainer/VBoxContainer/ItemList

var _item: Item
var methods: Array[String] = []


func _on_button_button_up() -> void:
	clear()


func start(item: Item):
	if not item:
		return
	
	clear()
	show()
	_item = item
	
	if item.has_method("use"):
		item_list.add_item("Use item")
		methods.append("use")
	
	if item.has_method("equipe_item"):
		item_list.add_item("Equipe item")
		methods.append("equipe_item")
	
	if item.has_method("unequipe_item"):
		item_list.add_item("Unequipe item")
		methods.append("unequipe_item")


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var clicked_method = methods[index]
	_item.call(clicked_method, SignalBus)
	
	clear()


func clear():
	item_list.clear()
	hide()
