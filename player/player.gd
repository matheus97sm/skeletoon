class_name Player extends CharacterBody2D


@export var player_base_stats: PlayerStats
@export var player_stats: PlayerStats
@export var equipment: Equipment

@onready var player_animations: AnimationPlayer = %PlayerAnimations

var inventory: Inventory = Inventory.new()
var gravity = 1400
var player_utils = PlayerUtils.new()

func _ready() -> void:
	await owner.ready
	update_player_stats()
	SignalBus.health_updated.emit(player_stats.health, player_stats.max_health)
	
#	Player Actions
	SignalBus.restore_player_health.connect(heal_player)
	
#	Combat
	SignalBus.inflict_damage_to_enemy.connect(inflict_damage_to_enemy)
	
#	Inventory
	SignalBus.remove_item_from_inventory.connect(remove_inventory_item)
	SignalBus.equipe_item.connect(equipe_item)
	SignalBus.unequipe_item.connect(unequipe_item)


# Player Stats
func update_player_stats():
	var new_player_stats = player_utils.calculate_player_stats(player_base_stats, player_stats.health, equipment)
	player_stats = new_player_stats
	SignalBus.stats_updated.emit(player_stats)


# Player Actions
func heal_player(quantity: float):
	var new_health = player_stats.health + quantity
	
	if new_health >= player_stats.max_health:
		player_stats.health = player_stats.max_health
		SignalBus.health_updated.emit(player_stats.health, player_stats.max_health)
		return
	
	player_stats.health = new_health
	SignalBus.health_updated.emit(player_stats.health, player_stats.max_health)


#Combat
func inflict_damage_to_enemy(enemy: CharacterBody2D):
	if not enemy.has_method("take_damage"):
		print("It looks like this is not an enemy.")
		return
	
	enemy.take_damage(player_stats.attack)


# Inventory
func on_item_picked_up(item: Item):
	inventory.add_item(item)


func remove_inventory_item(item_name: String, quantity: int):
	var item = inventory.get_item_by_name(item_name)
	inventory.remove_item(item, quantity)


func equipe_item(item: EquipmentItem):
	if item.equipment_type == EquipmentItem.EQUIPMENT_TYPE.WEAPON:
		equipment.weapon = item
	
	update_player_stats()
	SignalBus.equipment_updated.emit(equipment)


func unequipe_item(item: EquipmentItem):
	if item.equipment_type == EquipmentItem.EQUIPMENT_TYPE.WEAPON:
		equipment.weapon = null
	
	update_player_stats()
	SignalBus.equipment_updated.emit(equipment)
