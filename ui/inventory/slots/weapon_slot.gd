extends PanelContainer

@onready var item_texture: TextureRect = %ItemTexture

var _item: EquipmentItem


func _ready() -> void:
	SignalBus.equipment_updated.connect(update_equipment_item)


func update_equipment_item(equipment: Equipment):
	_item = equipment.weapon
	display_item(_item)


func display_item(item: EquipmentItem):
	if not item:
		remove_item()
		return
	
	item_texture.texture = item.icon
	_item = item
	
	if item.hover_text:
		tooltip_text = item.hover_text


func remove_item():
	_item = null
	item_texture.texture = null
	tooltip_text = ""


func _gui_input(event):
	if not event is InputEventMouseButton:
		return
	
	if event.double_click:
		handle_double_click()
	
	if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		SignalBus.open_inventory_item_menu.emit(_item, get_global_mouse_position())


func handle_double_click():	
	if _item.has_method("unequipe_item"):
		_item.call("unequipe_item", SignalBus, _item)
		return
