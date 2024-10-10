extends MarginContainer


@export var label: String
@export var value: String

@onready var stats_label: Label = $StatsContainer/StatsLabel
@onready var stats_value: Label = $StatsContainer/StatsValue


func _ready() -> void:
	stats_label.text = label
	stats_value.text = value
