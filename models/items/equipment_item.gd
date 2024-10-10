class_name EquipmentItem extends Item

enum EQUIPMENT_TYPE { WEAPON, ARMOR }

@export var attack: float = 0.0
@export var durability: float = 0.0

@export var texture: Texture2D

@export var equipment_type: EQUIPMENT_TYPE


func equipe_item(item: EquipmentItem, signal_bus: SignalBus):
	signal_bus.equipe_item.emit(item)
