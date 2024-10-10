extends Node


# Player Actions
signal restore_player_health(quantity: float)


# Stats Updates
signal health_updated(health: float, max_health: float)
signal stats_updated(player_stats: PlayerStats)


# Combat
signal inflict_damage_to_enemy(enemy: CharacterBody2D)


# Inventory
signal remove_item_from_inventory(item_name: String, quantity: int)
signal inventory_updated


# Items
signal add_item_in_player_range(item: Item)
signal remove_item_from_player_range(item: Item)
signal get_items_in_player_range(items: Array[Item])
signal item_dropped(item: Item, global_position: Vector2)


# Equipments
signal equipe_item(item: EquipmentItem)
signal unequipe_item(item: EquipmentItem)
signal equipment_updated(equipment: Equipment)


# GUI
signal open_inventory_item_menu(item: Item, global_position: Vector2)
