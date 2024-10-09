class_name ConsumbaleItem extends Item

@export var health_restore: int = 0

func use(signal_bus: SignalBus):
	signal_bus.restore_player_health.emit(health_restore)
	signal_bus.remove_item_from_inventory.emit(name, 1)
