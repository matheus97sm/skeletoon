extends Node2D


var items_in_player_range: Array[Item]

const PICKUP = preload("res://items/pickup/pickup.tscn")


func _ready() -> void:
	SignalBus.item_dropped.connect(spawn_item)
	SignalBus.add_item_in_player_range.connect(add_item_in_player_range)
	SignalBus.remove_item_from_player_range.connect(remove_item_from_player_range)


func spawn_item(item: Item, _global_position: Vector2):
	var new_pickup_item = PICKUP.instantiate()
	new_pickup_item.item = item
	add_child(new_pickup_item)
	new_pickup_item.global_position = _global_position


func add_item_in_player_range(item: Item):
	items_in_player_range.append(item)
	get_items_in_player_range()


func remove_item_from_player_range(item: Item):
	items_in_player_range.erase(item)
	get_items_in_player_range()


func get_items_in_player_range():
	SignalBus.get_items_in_player_range.emit(items_in_player_range)
