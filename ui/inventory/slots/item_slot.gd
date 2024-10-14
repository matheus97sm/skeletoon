extends PanelContainer

var _item: Item
var _store_position: int

@onready var item_texture: TextureRect = %ItemTexture
@onready var quantity_label: Label = %QuantityLabel


func display_item(item: Item, store_position: int):
	_store_position = store_position
	
	if not item:
		return
	
	_item = item.duplicate()
	
	item_texture.texture = item.icon
	if item.quantity > 1:
		quantity_label.text = str(item.quantity)
	
	if item.hover_text:
		tooltip_text = item.hover_text


func remove_item():
	_item = null
	
	item_texture.texture = null
	quantity_label.text = ""
	
	tooltip_text = ""


func _gui_input(event):
	if not event is InputEventMouseButton:
		return
	
	if event.double_click:
		handle_double_click()
	
	if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		SignalBus.open_inventory_item_menu.emit(_item, get_global_mouse_position())


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	SignalBus.change_item_position.emit(data._item, data._store_position, _store_position)


func handle_double_click():
	if not _item:
		return
	
	if _item.has_method("use"):
		_item.call("use", SignalBus)
	
	if _item.has_method("equipe_item"):
		_item.call("equipe_item", SignalBus, _item)


func _on_mouse_entered() -> void:
	var item_position = global_position + (size / 2)
	SignalBus.item_hovered.emit(_item, item_position)


func _on_mouse_exited() -> void:
	var item_position = global_position + (size / 2)
	SignalBus.item_hovered.emit(null, item_position)
