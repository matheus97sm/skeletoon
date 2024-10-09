extends Panel


@onready var health_bar: ProgressBar = %HealthBar
@onready var player: Player = %Player


func set_health(health: int, max_health: int):
	health_bar.max_value = max_health
	health_bar.value = health


func _on_player_update_health(health: int, max_health: int) -> void:
	set_health(health, max_health)
