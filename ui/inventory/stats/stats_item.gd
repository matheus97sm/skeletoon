extends MarginContainer


@export var label: String

@onready var stats_label: Label = $StatsContainer/StatsLabel
@onready var stats_value: Label = $StatsContainer/StatsValue


func _ready() -> void:
	stats_label.text = label + ":"


func set_value(value: String) -> void:
	stats_value.text = value
