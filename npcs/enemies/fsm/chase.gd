extends EnemyState


var random_chase_direction: int = 1


func enter():
	animation_player.play(CHASE)


func update(delta: float):
	if not enemy.chase_target:
		state_transition.emit(IDLE)
		return
	
	var distance_from_player = abs(enemy.chase_target.global_position.x - enemy.global_position.x)
	
	chase_enemy(distance_from_player)
	
	if enemy.is_attacks_on_cooldown:
		return
	
	if distance_from_player <= 400:
		state_transition.emit(ATTACK)


func chase_enemy(distance_from_player: float) -> void:
	var direction: int = 1
	
	var enemy_is_on_left = enemy.chase_target.global_position.x < enemy.global_position.x
	
	if enemy_is_on_left:
		direction = -1

	start_random_chase(distance_from_player)
	direction = direction * random_chase_direction
	
	enemy.velocity.x = direction * enemy.stats.speed
	enemy.move_and_slide()
	
	enemy.flip_enemy(Vector2(direction, 1))


func start_random_chase(distance_from_player: float) -> void:
	if distance_from_player <= 50:
		random_chase_direction = -1
		return
	
	if distance_from_player >= 250:
		random_chase_direction = 1
		return
