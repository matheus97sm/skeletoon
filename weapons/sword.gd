extends Area2D

@onready var sword_texture: Sprite2D = $SwordTexture


func _ready() -> void:
	SignalBus.equipment_updated.connect(update_weapon)


func update_weapon(equipment: Equipment):
	if equipment.type != Enums.EQUIPMENT_TYPE.WEAPON:
		return
	
	if not equipment.item:
		sword_texture.texture = null
		return
	
	sword_texture.texture = equipment.item.texture


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("take_damage"):
		SignalBus.inflict_damage_to_enemy.emit(body)
