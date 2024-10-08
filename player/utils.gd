class_name PlayerUtils extends Node


func flip_player_sprite(player_sprite: Node2D):
	var input_direction_x := Input.get_axis("move_left", "move_right")

	if input_direction_x < 0:
		player_sprite.scale = Vector2(-1, 1)
		return
	
	if input_direction_x > 0:
		player_sprite.scale = Vector2(1, 1)
		return
