extends PlayerState

func enter():
	player.player_animations.play("attack_sword_1")


func update(delta: float):
	print(player.player_animations.current_animation)
	if player.player_animations.current_animation == "attack_sword_1":
		return
	
	state_transition.emit(IDLE)
