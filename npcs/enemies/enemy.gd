extends CharacterBody2D

@export var stats: EnemyStats
@export var attack_cooldown: float = 1

@onready var health_bar: ProgressBar = %HealthBar

var can_attack: bool = true
var attack_targets: Array[CharacterBody2D]
var chase_target: CharacterBody2D

const PICKUP = preload("res://items/pickup/pickup.tscn")

signal target_on_chase_radius


func _ready() -> void:
	update_health_bar()


func take_damage(damage: float, is_crit: bool = false) -> void:
	var damage_taken = damage - stats.deffence
	if damage_taken < 0: damage_taken = 0
	
	DamageNumbers.display_number(damage_taken, global_position, is_crit)
	
	stats.health -= damage
	update_health_bar()
	die()


func update_health_bar():
	health_bar.max_value = stats.max_health
	health_bar.value = stats.health
	
	if stats.health < stats.max_health:
		health_bar.show()


func die() -> void:
	if stats.health > 0:
		return
	
	if stats.drop:
		SignalBus.item_dropped.emit(stats.drop, global_position)
	
	queue_free()


func applies_attack() -> void:
	if not attack_targets or attack_targets.size() == 0:
		return
	
	if not can_attack:
		return
	
	for target in attack_targets:
		target.take_damage(stats.attack)
	
	can_attack = false
	get_tree().create_timer(attack_cooldown).connect("timeout", set_can_attack)


func set_can_attack():
	can_attack = true
	
	applies_attack()


func _on_attack_box_body_entered(body: CharacterBody2D) -> void:
	if body is not Player: return
	
	if body.has_method("take_damage"):
		attack_targets.append(body)
		applies_attack()


func _on_attack_box_body_exited(body: Node2D) -> void:
	if body.has_method("take_damage"):
		attack_targets.erase(body)


func _on_chase_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		chase_target = body
		target_on_chase_radius.emit()


func _on_chase_radius_body_exited(body: Node2D) -> void:
	if body is Player:
		chase_target = null
		target_on_chase_radius.emit()
