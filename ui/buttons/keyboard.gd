extends MarginContainer


@export var key_label: String

@onready var key_name: Label = %KeyName


func _ready() -> void:
	await owner.ready
	key_name.text = key_label
