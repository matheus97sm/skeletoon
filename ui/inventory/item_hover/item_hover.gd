extends Panel


var _item: Item
var is_mouse_hover: bool = false

@onready var item_name: Label = %ItemName
@onready var item_description: RichTextLabel = %ItemDescription
@onready var item_texture: TextureRect = %ItemTexture


func _ready() -> void:
	SignalBus.item_hovered.connect(display_item)


func _process(delta: float) -> void:
	global_position = get_global_mouse_position() + Vector2(10, 10)


func display_item(item: Item, item_global_position: Vector2) -> void:
	if is_mouse_hover: return
	
	if item == null:
		hide()
		return
	
	_item = item
	
	item_name.text = _item.name
	item_description.text = _item.description
	item_texture.texture = _item.icon
	show()
	
	if item_global_position:
		global_position = item_global_position


func _on_mouse_entered() -> void:
	is_mouse_hover = true


func _on_mouse_exited() -> void:
	is_mouse_hover = false
