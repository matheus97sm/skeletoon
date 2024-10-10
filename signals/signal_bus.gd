extends Node


signal restore_player_health(quantity: float)

signal remove_item_from_inventory(item_name: String, quantity: int)

signal inventory_updated

# Items
signal add_item_in_player_range(item: Item)
signal remove_item_from_player_range(item: Item)
signal get_items_in_player_range(items: Array[Item])
signal item_dropped(item: Item, global_position: Vector2)


# Equipments
signal equipe_item(item: EquipmentItem)


# GUI
signal open_inventory_item_menu(item: Item, global_position: Vector2)
