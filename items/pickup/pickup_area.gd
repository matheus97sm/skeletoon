extends Area2D


signal player_entered_or_exit(player: CharacterBody2D)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("on_item_picked_up"):
		player_entered_or_exit.emit(body)
		


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("on_item_picked_up"):
		player_entered_or_exit.emit(null)
