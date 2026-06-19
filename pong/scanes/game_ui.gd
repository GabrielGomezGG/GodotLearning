extends Control

@onready var pointPlayer1: Label = $CanvasLayer/MarginContainer/VBoxContainer/point
@onready var pointPlayer2: Label = $CanvasLayer/MarginContainer2/VBoxContainer/point
@onready var counter: Label = $CanvasLayer/Counter

func _on_ball_set_point(orientation: int) -> void:
	#pointPlayer1.text = str(Screen.player1Point)
	#pointPlayer2.text = str(Screen.player2Point)
	if orientation > 0:
		text_animation(pointPlayer1, str(Screen.player1Point), 16)
	else:
		text_animation(pointPlayer2, str(Screen.player2Point), 16)
	
	counter.text = "x" + str(Ball.counter)


func _on_ball_colission() -> void:
	
	#var tween = create_tween()
	#tween.tween_method(textSize,96,96*1.5,0.15)
	#tween.tween_method(textSize,96*1.5, 96,0.15)
	#counter.text = "x" + str(Ball.counter)
	
	text_animation(counter, "x" + str(Ball.counter), 96)
	
func text_animation(label: Label, text: String, fontSize: int):
	
	var tween = create_tween()
	tween.tween_method(func(size): label.add_theme_font_size_override("font_size", int(size)),fontSize,fontSize*1.5,0.15)
	tween.tween_method(func(size): label.add_theme_font_size_override("font_size", int(size)),fontSize*1.5, fontSize,0.15)
	label.text = text

func textSize(size, label: Label):
	counter.add_theme_font_size_override("font_size", int(size))
