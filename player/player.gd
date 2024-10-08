class_name Player extends CharacterBody2D

signal update_health

@export var player_speed = 200.0
@export var player_jump_speed = -400.0
@export var player_max_health = 100.0
@export var player_health = 100.0
@onready var player_animations: AnimationPlayer = %PlayerAnimations

var inventory: Inventory = Inventory.new()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	%PlayerAnimations.play("idle")
	await owner.ready
	update_health.emit(player_health, player_max_health)


func on_item_picked_up(item: Item):
	inventory.add_item(item)
