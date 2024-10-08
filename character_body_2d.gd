extends CharacterBody2D


@export var max_health = 100.0
@export var health = 100.0


func take_damage(damage: float) -> void:
	health -= damage
