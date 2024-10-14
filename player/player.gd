class_name Player extends CharacterBody2D


@export var player_base_stats: PlayerStats
@export var player_stats: PlayerStats
@export var equipments: Equipments

@onready var player_animations: AnimationPlayer = %PlayerAnimations

var inventory: Inventory = Inventory.new()
var gold: int = 0
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
	var new_player_stats = player_utils.calculate_player_stats(player_base_stats, player_stats.health, equipments)
	player_stats = new_player_stats
	SignalBus.stats_updated.emit(player_stats)


func update_player_health(new_health: float, max_health: float = player_stats.max_health):
	player_stats.health = new_health
	SignalBus.health_updated.emit(player_stats.health, player_stats.max_health)
	


# Player Actions
func heal_player(quantity: float):
	var new_health = player_stats.health + quantity
	
	if new_health >= player_stats.max_health:
		update_player_health(player_stats.max_health)
		return
	
	update_player_health(new_health)


#Combat
func inflict_damage_to_enemy(enemy: CharacterBody2D):
	if enemy == self:
		return
	
	if not enemy.has_method("take_damage"):
		print("It looks like this is not an enemy.")
		return
	
	var critical_rng = randf_range(0, 1)
	var is_crit = critical_rng < player_stats.crit_chance
	
	var damage = player_stats.attack
	
	if is_crit: damage = damage * player_stats.crit_damage
	
	enemy.take_damage(damage, is_crit)


func take_damage(damage: float):
	var damage_taken = damage - player_stats.deffence
	
	if damage_taken <= 0:
		return
	
	var new_health = player_stats.health - damage_taken
	update_player_health(new_health)
	DamageNumbers.display_number(damage_taken, global_position, true)


# Inventory
func on_item_picked_up(item: Item):
	inventory.add_item(item)


func remove_inventory_item(item_name: String, quantity: int):
	var item = inventory.get_item_by_name(item_name)
	inventory.remove_item(item, quantity)


func equipe_item(item: EquipmentItem):
	var available_slot: Equipment
	
	for slot in equipments.get_all_equipments():
		if slot.type != item.equipment_type:
			continue
		
		if not slot.item:
			available_slot = slot
			break
		
		available_slot = slot
	
	available_slot.item = item
	
	update_player_stats()
	SignalBus.equipment_updated.emit(available_slot)


func unequipe_item(equipment: Equipment):
	for slot in equipments.get_all_equipments():
		if equipment.slot != slot.slot:
			continue
		
		slot.item = null
		break
	
	update_player_stats()
	SignalBus.equipment_updated.emit(equipment)
