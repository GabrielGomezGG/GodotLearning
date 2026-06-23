extends Control

signal reset_game

@onready var label: Label = $CanvasLayer/Label
@onready var button: Button = $CanvasLayer/Button

func _ready() -> void:
	button.pressed.connect(on_button_pressed)

func _process(delta: float) -> void:
	if GameScreen.gameOver:
		button.visible = true
	else: button.visible = false

func _on_game_screen_update_score(text: String) -> void:
	label.text = text
	print("POINT")

func on_button_pressed():
	reset_game.emit()
