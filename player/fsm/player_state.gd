class_name PlayerState extends State


const IDLE = "idle"
const WALKING = "walking"
const ATTACK = "attack"
const JUMPING = "jumping"
const FALLING = "falling"
const DASHING = "dashing"

var player: Player
var player_utils = PlayerUtils.new()

@onready var skeletoon: Node2D = %Skeletoon


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
