extends EnemyState

var attack_type := 'range'

@export var shot_duration: float = 0.3
@export var shot_scene: PackedScene
@export var projectile_speed: float = 200.0
@export var projectile_max_travel_distance: float = 500.0

func handle_attack(finished_attack: Signal, target_direction: Vector2) -> void:
	animation_player.play(IDLE)
	
	var shot = shot_scene.instantiate()
	shot.attack_damage = enemy.stats.attack
	shot.projectile_speed = projectile_speed
	shot.projectile_max_travel_distance = projectile_max_travel_distance
	shot.target_direction = target_direction
	shot.global_position = enemy.projectile_spawn_point.global_position
	add_child(shot)
	
	get_tree().create_timer(shot_duration).connect('timeout', func(): finished_attack.emit())
