extends Control


@export var label: String
@export var button_label: String

@onready var keyboard: MarginContainer = %Keyboard
@onready var action_label: Label = %ActionLabel


func _ready() -> void:
	keyboard.key_label = button_label
	action_label.text = label
