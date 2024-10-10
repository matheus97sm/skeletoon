extends Area2D

@onready var sword_texture: Sprite2D = $SwordTexture


func _ready() -> void:
	SignalBus.equipment_updated.connect(update_weapon)


func update_weapon(equipment: Equipment):
	sword_texture.texture = equipment.weapon.texture


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(50)
