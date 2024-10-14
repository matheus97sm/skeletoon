extends EnemyState

var chase_target: CharacterBody2D


func enter():
	animation_player.play(CHASE)


func _physics_process(delta: float) -> void:
	if not enemy.chase_target: return
	
	var direction: int = 1
	
	var enemy_is_on_left = enemy.chase_target.global_position.x < enemy.global_position.x
	
	if enemy_is_on_left:
		direction = -1
	
	enemy.velocity.x = direction * enemy.stats.speed
	enemy.move_and_slide()


func update(delta: float):
	pass
