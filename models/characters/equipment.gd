class_name Equipment extends Resource


@export var weapon: EquipmentItem

func get_all_equipments() -> Array[EquipmentItem]:
	return [weapon]
