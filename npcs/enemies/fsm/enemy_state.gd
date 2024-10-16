class_name EnemyState extends State


var animation_player: AnimationPlayer
var enemy: CharacterBody2D

const IDLE = "idle"
const CHASE = "chase"
const ATTACK = "attack"


func _ready() -> void:
	await owner.ready
	enemy = owner.enemy
	animation_player = owner.animation_player
	assert(enemy != null, "The EnemyState state type must be used only in the enemies scene. It needs the owner to be a Enemy node.")
