extends Area2D

@export var item: Item

@onready var item_sprite: Sprite2D = %ItemSprite
@onready var press_button: Control = %PressButton

var player: Player = null
var can_pick_up: bool = false


func _ready() -> void:
	item_sprite.texture = item.icon
	SignalBus.get_items_in_player_range.connect(get_items_in_player_range)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("on_item_picked_up"):
		player = body
		SignalBus.add_item_in_player_range.emit(item)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("on_item_picked_up"):
		player = null
		SignalBus.remove_item_from_player_range.emit(item)


func _unhandled_key_input(event: InputEvent) -> void:
	if not can_pick_up: return
	
	if event.is_action_released("pick_items"):
		if player == null:
			return
		
		player.on_item_picked_up(item)
		queue_free()


func get_items_in_player_range(items: Array[Item]):
	if items.size() > 0 and items[0] == item and player:
		press_button.show()
		can_pick_up = true
		return
	
	can_pick_up = false
	press_button.hide()
