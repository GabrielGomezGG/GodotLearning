extends Control

@onready var pointPlayer1: Label = $CanvasLayer/MarginContainer/VBoxContainer/point
@onready var pointPlayer2: Label = $CanvasLayer/MarginContainer2/VBoxContainer/point


func _on_ball_set_point() -> void:
	pointPlayer1.text = str(Screen.player1Point)
	pointPlayer2.text = str(Screen.player2Point)
