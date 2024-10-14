class_name Stats extends Resource


# Health
@export var health: float = 50.0 ## The character actual health, when this reach 0, the character must die.
@export var max_health: float = 50.0 ## The maximum amount of health the character can have.

# Speeds
@export var speed: float = 200.0 ## The character movement speed.
@export var jump_speed: float = -800.0 ## The character jump speed and force.

# Attack Stats
@export var attack: float = 5.0 ## Character base attack without equipment.
@export_range(0, 1) var crit_chance: float = 0.0 ## Defines the character crit chance, 0 means 0% and 1 means 100%.
@export var crit_damage: float = 1.0 ## Defines the character crit damage multiplier, e.g. 1.5 means the damage will be 150% of player attack

# Deffence stats
@export var deffence: float = 1.0 ## The amount of deffence, this will reduce the damage taken.
