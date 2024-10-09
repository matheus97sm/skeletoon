extends CharacterBody2D

@export var stats: EnemyStats

@onready var health_bar: ProgressBar = %HealthBar

const PICKUP = preload("res://items/pickup/pickup.tscn")

func _ready() -> void:
	update_health_bar()


func take_damage(damage: float) -> void:
	stats.health -= damage
	update_health_bar()
	die()


func update_health_bar():
	health_bar.max_value = stats.max_health
	health_bar.value = stats.health
	
	if stats.health < stats.max_health:
		health_bar.show()


func die() -> void:
	if stats.health > 0:
		return
	
	if stats.drop:
		SignalBus.item_dropped.emit(stats.drop, global_position)
	
	queue_free()
