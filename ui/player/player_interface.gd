extends Panel


@onready var health_bar: ProgressBar = %HealthBar


func set_health(health: int, max_health: int):
	health_bar.max_value = max_health
	health_bar.value = health
