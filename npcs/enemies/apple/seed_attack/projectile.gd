extends Area2D

var target_direction: Vector2
var attack_damage: float
var travelled_distance: float = 0.0

@export var projectile_speed: float = 200.0
@export var projectile_max_travel_distance: float = 500.0


func _ready() -> void:
	look_at(target_direction)


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * projectile_speed * delta
	
	travelled_distance += projectile_speed * delta
	if travelled_distance > projectile_max_travel_distance:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	
	if body is not Player: return
	
	if body.has_method('take_damage'):
		body.take_damage(attack_damage)
