extends EnemyState


func enter():
	enemy.target_on_chase_radius.connect(target_on_chase_radius)
	enemy.velocity.x = 0.0
	animation_player.play("idle")


func update(delta: float):
	pass


func target_on_chase_radius():
	enemy.target_on_chase_radius.disconnect(target_on_chase_radius)
	state_transition.emit(CHASE)
