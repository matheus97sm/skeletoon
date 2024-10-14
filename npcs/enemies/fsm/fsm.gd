class_name EnemiesFiniteStateMachine extends Node


@export var enemy: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var initial_state: State

var states: Dictionary = {}
var current_state: State


func _ready() -> void:
	await owner.ready
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
		
		if initial_state:
			initial_state.enter()
			current_state = initial_state


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func _process(delta: float) -> void:
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)


func change_state(new_state_name: String) -> void:
	var new_state: State = states.get(new_state_name.to_lower())
	
	if !new_state:
		print("The state " + new_state_name + " does not exists")
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
