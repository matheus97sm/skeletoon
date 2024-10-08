extends Area2D

@export var item: Item

@onready var item_sprite: Sprite2D = %ItemSprite


func _ready() -> void:
	item_sprite.texture = item.icon


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("on_item_picked_up"):
		body.on_item_picked_up(item)
		queue_free()
