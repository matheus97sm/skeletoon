extends PlayerState

func enter():
	player.player_animations.play(IDLE)


func update(delta: float):
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.player_speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	player_utils.flip_player_sprite(skeletoon)

	if not player.is_on_floor():
		return
		
	if is_equal_approx(input_direction_x, 0.0):
		state_transition.emit(IDLE)
		return
	
	state_transition.emit(WALKING)
