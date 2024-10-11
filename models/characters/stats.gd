class_name Stats extends Resource


# Health
@export var health: float = 50.0
@export var max_health: float = 50.0

# Speeds
@export var speed: float = 200.0
@export var jump_speed: float = -800.0

# Attack Stats
## Player base attack without equipment.
@export var attack: float = 5.0
## Defines the character crit chance, 0 means 0% and 1 means 100%.
@export_range(0, 1) var crit_chance: float = 0.0
## Defines the character crit damage multiplier, e.g. 1.5 means the damage will be 150% of player attack
@export var crit_damage: float = 1.0

# Deffence stats
@export var deffence: float = 1.0
