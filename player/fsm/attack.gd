extends PlayerState


func enter():
	if not player.equipment.weapon:
		return
	
	player.player_animations.play("attack_sword_1")


func update(delta: float):
	if player.player_animations.current_animation == "attack_sword_1":
		return
	
	state_transition.emit(IDLE)
