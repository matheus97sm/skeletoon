extends EnemyState

var attack_type := 'melee'
var direction: int
var can_attack: bool = false

@export var tackle_duration: float = 0.5

func handle_attack(finished_attack: Signal, target_direction: Vector2) -> void:
	can_attack = true
	
	var enemy_is_on_left = target_direction.x < enemy.global_position.x

	direction = 1
	if enemy_is_on_left:
		direction = -1
	
	get_tree().create_timer(tackle_duration).connect('timeout', func(): finish_attack(finished_attack))


func _physics_process(delta: float) -> void:
	if not can_attack:
		return
	
	enemy.disable_attack_box()
	enemy.velocity.x = enemy.stats.speed * 2.5 * direction
	enemy.move_and_slide()


func finish_attack(finished_attack: Signal) -> void:
	can_attack = false
	finished_attack.emit()
