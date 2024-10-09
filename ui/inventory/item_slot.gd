extends PanelContainer

@onready var item_texture: TextureRect = %ItemTexture
@onready var quantity_label: Label = %QuantityLabel

const ITEM_MENU = preload("res://ui/item_menu/item_menu.tscn")

var _item: Item

func display_item(item: Item):
	item_texture.texture = item.icon
	quantity_label.text = str(item.quantity)
	_item = item
	
	if item.hover_text:
		tooltip_text = item.hover_text


func _gui_input(event):
	if not event is InputEventMouseButton:
		return
		
	if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var new_item_menu = ITEM_MENU.instantiate()
		add_child(new_item_menu)
		new_item_menu.start(_item)
		new_item_menu.global_position = get_local_mouse_position()
