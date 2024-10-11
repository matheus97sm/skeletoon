extends Panel


@onready var health_bar: ProgressBar = %HealthBar
@onready var player: Player = %Player


func _ready() -> void:
	SignalBus.health_updated.connect(set_health)


func set_health(health: int, max_health: int):
	health_bar.max_value = max_health
	health_bar.value = health
