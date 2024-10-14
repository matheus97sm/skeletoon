extends GridContainer


@export var equipment_slots: Array[EquipmentSlot]

const EQUIPMENT_SLOT = preload("res://ui/inventory/slots/equipment_slot.tscn")


func _ready() -> void:
	if equipment_slots.size() == 0:
		return
	
	for equipment_slot in equipment_slots:
		var new_equipment_slot_scene = EQUIPMENT_SLOT.instantiate()
		new_equipment_slot_scene.custom_slot_texture = equipment_slot.equipment_slot_texture
		new_equipment_slot_scene.equipment_slot = equipment_slot.equipment_slot
		new_equipment_slot_scene.equipment_type = equipment_slot.equipment_type
		add_child(new_equipment_slot_scene)
