extends Resource

class_name Item


@export var name: String
@export var icon: Texture2D
@export var price: int = 0
@export var quantity: int = 1
@export var stack_size: int = 99
@export_multiline var hover_text: String
@export_multiline var description: String
