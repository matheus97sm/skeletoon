extends EnemyState

var target: CharacterBody2D
var target_direction: Vector2
var can_attack: bool = false
var choosed_attack: Node

signal finished_attack


func enter() -> void:
	if enemy.is_attacks_on_cooldown:
		state_transition.emit(CHASE)
		return
	
	if not enemy.chase_target:
		state_transition.emit(IDLE)
		return
	
	var is_enemy_on_melee_range = abs(enemy.chase_target.global_position.x - enemy.global_position.x) < 200
	var attack_type = 'melee' if is_enemy_on_melee_range else 'range'
	var attacks = get_possible_attacks(attack_type)
	
	if attacks.size() == 0:
		state_transition.emit(CHASE)
		return
	
	choosed_attack = attacks.pick_random()
	
	can_attack = true
	
	target = enemy.chase_target
	target_direction = target.global_position
	
	if choosed_attack:
		choosed_attack.handle_attack(finished_attack, target_direction)
	
	finished_attack.connect(end_attack)
	get_tree().create_timer(enemy.attack_cooldown).connect("timeout", end_cooldown)
	enemy.toggle_is_attacks_on_cooldown(true)


func exit() -> void:
	can_attack = false


func get_possible_attacks(attack_type: String = 'all') -> Array[Node]:
	var attacks: Array[Node] = get_children()
	
	if attack_type == 'all':
		return attacks
	
	var filtered_attacks: Array[Node] = []
	
	for attack in attacks:
		if attack.attack_type == attack_type:
			filtered_attacks.append(attack)
	
	return filtered_attacks

func end_attack() -> void:
	can_attack = false
	enemy.disable_attack_box(true)
	state_transition.emit(CHASE)


func end_cooldown() -> void:
	enemy.toggle_is_attacks_on_cooldown(false)
