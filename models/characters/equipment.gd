class_name Equipment extends Resource


@export var item: EquipmentItem
@export var type: Enums.EQUIPMENT_TYPE
@export var slot: Enums.EQUIPMENT_SLOT


func equipe_item(signal_bus: SignalBus, item: Equipment):
	signal_bus.equipe_item.emit(item)


func unequipe_item(signal_bus: SignalBus, item: Equipment):
	signal_bus.unequipe_item.emit(item)
