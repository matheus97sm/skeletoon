extends PlayerState

@onready var player_animations: AnimationPlayer = %PlayerAnimations


func enter():
	player.velocity.x = 0.0
	player_animations.play("idle")


func update(delta: float):
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_transition.emit(WALKING)
		return
	
	if Input.is_action_just_pressed("attack"):
		state_transition.emit(ATTACK)
		return
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(JUMPING)
		return
	
