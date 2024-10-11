extends PlayerState


func enter():
	var player_weapon = player.equipments.weapon.item
	
	if not player_weapon:
		return
	
	player.player_animations.play("attack_sword_1")


func update(delta: float):
	if player.player_animations.current_animation == "attack_sword_1":
		return
	
	state_transition.emit(IDLE)
