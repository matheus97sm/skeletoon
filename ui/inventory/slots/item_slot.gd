extends PanelContainer

@onready var item_texture: TextureRect = %ItemTexture
@onready var quantity_label: Label = %QuantityLabel

var _item: Item

func display_item(item: Item):
	if not item:
		return
	
	item_texture.texture = item.icon
	quantity_label.text = str(item.quantity)
	_item = item
	
	if item.hover_text:
		tooltip_text = item.hover_text


func _gui_input(event):
	if not event is InputEventMouseButton:
		return
	
	if event.double_click:
		handle_double_click()
	
	if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		SignalBus.open_inventory_item_menu.emit(_item, get_global_mouse_position())


func handle_double_click():
	if not _item:
		return
	
	if _item.has_method("use"):
		_item.call("use", SignalBus)
	
	if _item.has_method("equipe_item"):
		_item.call("equipe_item", SignalBus, _item)
