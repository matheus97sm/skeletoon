class_name EquipmentItem extends Item

# Attack Stats
@export var attack: float = 0.0 ## The attack that will be added to the player attack stats
@export_range(0, 1) var crit_chance: float = 0.0 ## The crit chance that will be added to the player crit chance stats
@export var crit_damage: float = 0.0 ## The crit damage that will be added to the player crit damage stats

# Equipment Stats
@export var durability: float = 100 ## The durability of the equipment. When it reach 0, the equipment will broken and the player will have to fix it to use again.

# Equipment infos
@export var texture: Texture2D ## Defines the texture that will be used in game.
@export var equipment_type: Enums.EQUIPMENT_TYPE ## Defines the equipment type, that can be any of [EQUIPMENT_TYPE]


func equipe_item(signal_bus: SignalBus, item: EquipmentItem):
	signal_bus.equipe_item.emit(item)


func unequipe_item(signal_bus: SignalBus, item: EquipmentItem):
	signal_bus.unequipe_item.emit(item)
