extends PlayerState

@export var dash_duration: float = 0.4

@onready var player_animations: AnimationPlayer = %PlayerAnimations

func enter():
	player_animations.play("dash")
	
	player.is_player_invunerable = true
	
	get_tree().create_timer(dash_duration).connect('timeout', handle_dash_finished)


func update(delta: float):
	if not player.is_on_floor():
		state_transition.emit(FALLING)
		return
	
	var direction = skeletoon.scale.x
	player.velocity.x = player.player_stats.dash_speed * direction
	
	player.move_and_slide()


func handle_dash_finished():
	player.is_player_invunerable = false
	state_transition.emit(WALKING)
