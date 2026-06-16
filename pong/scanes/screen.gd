extends Node2D


signal star_game(isPlayerOneTurn: bool)

@export var isPlayerOneTurn = true

@export var label1 = Label
@export var label2 = Label

var player1Point = 0
var player2Point = 0

func _ready() -> void:
	star_game.emit(isPlayerOneTurn)
	label1.text = str(player1Point)
	label2.text = str(player2Point)


func _on_ball_set_point() -> void:
	if(isPlayerOneTurn) :
		player1Point += 1
		label1.text = str(player1Point)
	else:
		player2Point += 1
		label2.text = str(player2Point)
	
	star_game.emit(isPlayerOneTurn)


func _on_ball_change_turn() -> void:
	isPlayerOneTurn = !isPlayerOneTurn
