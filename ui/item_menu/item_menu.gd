extends Panel

@onready var item_list: ItemList = $PanelContainer/MarginContainer/VBoxContainer/ItemList

var _item: Item
var methods: Array[String] = []


func _on_button_button_up() -> void:
	queue_free()


func start(item: Item):
	_item = item
	
	if item.has_method("use"):
		item_list.add_item("Use item")
		methods.append("use")


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var clicked_method = methods[index]
	_item.call(clicked_method, SignalBus)
	
	queue_free()
