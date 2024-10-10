extends CharacterBody2D

@onready var player_animations: AnimationPlayer = %PlayerAnimations


func _ready() -> void:
	player_animations.play("idle")
