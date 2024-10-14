extends Control

const PICKUP = preload("res://items/pickup/pickup.tscn")
@onready var pickup_items: Node2D = %PickupItems


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	SignalBus.remove_item_from_inventory.emit(data._item.name, data._item.quantity)
	pickup_items.spawn_item_on_player_location(data._item)
