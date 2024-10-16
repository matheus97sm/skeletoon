extends EnemyState

var target: CharacterBody2D
var direction: int = 1
var is_on_cooldown: bool = false
var can_attack: bool = false

@export var tackle_duration: float = 0.5

func enter() -> void:
	if is_on_cooldown:
		state_transition.emit(CHASE)
		return
	
	if not enemy.chase_target:
		state_transition.emit(IDLE)
		return
	
	can_attack = true
	
	target = enemy.chase_target
	
	var enemy_is_on_left = target.global_position.x < enemy.global_position.x
	
	direction = 1
	if enemy_is_on_left:
		direction = -1
	
	get_tree().create_timer(tackle_duration).connect("timeout", end_attack)
	get_tree().create_timer(enemy.attack_cooldown).connect("timeout", end_cooldown)
	is_on_cooldown = true


func update(delta: float) -> void:
	handle_tackle(delta)


func exit() -> void:
	can_attack = false


func handle_tackle(delta: float) -> void:
	if not can_attack: 
		state_transition.emit(CHASE)
		return
	
	enemy.toggle_attack_box()
	enemy.velocity.x = enemy.stats.speed * 2.5 * direction
	enemy.move_and_slide()


func end_attack() -> void:
	can_attack = false
	enemy.toggle_attack_box(true)


func end_cooldown() -> void:
	is_on_cooldown = false
