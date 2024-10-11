class_name PlayerUtils extends Node


func flip_player_sprite(player_sprite: Node2D):
	var input_direction_x := Input.get_axis("move_left", "move_right")

	if input_direction_x < 0:
		player_sprite.scale = Vector2(-1, 1)
		return
	
	if input_direction_x > 0:
		player_sprite.scale = Vector2(1, 1)
		return


func calculate_player_stats(player_base_stats: Stats, current_health: float, equipments: Equipments) -> Stats:
	var player_stats: PlayerStats
	
	player_stats = player_base_stats.duplicate()
	
	for equipment in equipments.get_all_equipments():
		if not equipment or not equipment.item:
			continue
		
		var item = equipment.item
		
		player_stats.attack += item.attack
		player_stats.crit_chance += item.crit_chance
		player_stats.crit_damage += item.crit_damage
	
	player_stats.health = current_health
	
	if player_stats.max_health < current_health:
		player_stats.health = player_stats.max_health
	
	return player_stats
