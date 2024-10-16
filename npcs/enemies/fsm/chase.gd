extends EnemyState


func enter():
	animation_player.play(CHASE)


func update(delta: float):
	if not enemy.chase_target:
		state_transition.emit(IDLE)
		return
	
	var direction: int = 1
	
	var enemy_is_on_left = enemy.chase_target.global_position.x < enemy.global_position.x
	
	if enemy_is_on_left:
		direction = -1
	
	
	enemy.velocity.x = direction * enemy.stats.speed
	enemy.move_and_slide()
	
	var distance_from_player = abs(enemy.chase_target.global_position.x - enemy.global_position.x)
	
	if distance_from_player <= 200:
		state_transition.emit(ATTACK)
		return
	
	if distance_from_player > 5 or distance_from_player < -5: 
		enemy.flip_enemy(Vector2(direction, 1))
