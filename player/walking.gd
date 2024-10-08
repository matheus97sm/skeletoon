extends PlayerState

@onready var player_animations: AnimationPlayer = %PlayerAnimations

func enter():
	player_animations.play("walk")


func update(delta: float):
	if not player.is_on_floor():
		state_transition.emit(FALLING)
		return
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(JUMPING)
		return
	
	if Input.is_action_just_pressed("attack"):
		state_transition.emit(ATTACK)
		return
	
	if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		state_transition.emit(IDLE)
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * player.player_speed
	
	player.move_and_slide()
	player_utils.flip_player_sprite(skeletoon)
