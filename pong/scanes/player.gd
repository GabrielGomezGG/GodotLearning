extends CharacterBody2D

@export var isPlayerOne = true

#var playerVelosity: float = 300.0
var playerActions : Array
var canMoveTop = true
var canMoveBottom = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if isPlayerOne: playerActions = ["player_1_up", "player_1_down"]
	else: playerActions = ["player_2_up", "player_2_down"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed(playerActions[0]) && position.y > -230:
		position.y -= Ball.velosity_ball * delta
	elif Input.is_action_pressed(playerActions[1]) && position.y < 230:
		position.y += Ball.velosity_ball * delta
