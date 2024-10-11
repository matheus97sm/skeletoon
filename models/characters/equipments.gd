class_name Equipments extends Resource


@export var weapon: Equipment
@export var helmet: Equipment
@export var chest: Equipment
@export var legs: Equipment
@export var boots: Equipment
@export var neckless: Equipment
@export var bracelet: Equipment
@export var ring_1: Equipment
@export var ring_2: Equipment


func get_all_equipments() -> Array[Equipment]:
	return [weapon, helmet, chest, legs, boots, neckless, bracelet, ring_1, ring_2]
