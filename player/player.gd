class_name Player extends CharacterBody2D

signal update_health

@export var player_stats: Stats
@onready var player_animations: AnimationPlayer = %PlayerAnimations

var inventory: Inventory = Inventory.new()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	await owner.ready
	update_health.emit(player_stats.health, player_stats.max_health)
	
	SignalBus.restore_player_health.connect(heal_player)
	SignalBus.remove_item_from_inventory.connect(remove_inventory_item)


func on_item_picked_up(item: Item):
	inventory.add_item(item)


func remove_inventory_item(item_name: String, quantity: int):
	var item = inventory.get_item_by_name(item_name)
	inventory.remove_item(item, quantity)


func heal_player(quantity: float):
	var new_health = player_stats.health + quantity
	
	if new_health >= player_stats.max_health:
		player_stats.health = player_stats.max_health
		update_health.emit(player_stats.health, player_stats.max_health)
		return
	
	player_stats.health = new_health
	update_health.emit(player_stats.health, player_stats.max_health)
