extends PanelContainer

@export var equipment_type: Enums.EQUIPMENT_TYPE
@export var equipment_slot: Enums.EQUIPMENT_SLOT
@export var custom_slot_texture: Texture2D

@onready var item_texture: TextureRect = %ItemTexture
@onready var slot_texture: TextureRect = %SlotTexture

var _equipment: Equipment


func _ready() -> void:
	SignalBus.equipment_updated.connect(update_equipment_item)
	if custom_slot_texture:
		slot_texture.texture = custom_slot_texture


func update_equipment_item(equipment: Equipment):
	if equipment.slot != equipment_slot:
		return
	
	_equipment = equipment
	display_item(_equipment)


func display_item(equipment: Equipment):
	if not equipment.item:
		remove_item()
		return
	
	_equipment = equipment
	
	item_texture.texture = equipment.item.icon
	if equipment.item.hover_text:
		tooltip_text = equipment.item.hover_text


func remove_item():
	_equipment.item = null
	item_texture.texture = null
	tooltip_text = ""


func _gui_input(event):
	if not event is InputEventMouseButton:
		return
	
	if event.double_click:
		handle_double_click()
	
	if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		SignalBus.open_inventory_item_menu.emit(_equipment, get_global_mouse_position())


func handle_double_click():
	if not _equipment.item:
		return
	
	if _equipment.has_method("unequipe_item"):
		_equipment.call("unequipe_item", SignalBus, _equipment)
		return
