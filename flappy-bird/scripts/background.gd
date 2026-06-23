extends Parallax2D

@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_next: Sprite2D = $Sprite2DNext

@export var backgrounds : Array[Texture2D]
var counter = 0

var current_sprite: Sprite2D
var next_sprite = Sprite2D 

func _ready() -> void:
	current_sprite = sprite_2d
	next_sprite = sprite_2d_next

	current_sprite.modulate.a = 1.0
	next_sprite.modulate.a = 0.0

func _on_timer_timeout() -> void:
	if GameScreen.gameOver:
		timer.stop()
		return
	
	counter += 1
	
	if counter < backgrounds.size():
		#sprite_2d.texture = backgrounds[counter]
		crossfade(backgrounds[counter])
	else:
		timer.stop()
		return
		

func crossfade(new_texture: Texture2D):
	next_sprite.texture = new_texture
	next_sprite.modulate.a = 0.0

	var tween = create_tween()

	tween.parallel().tween_property(
		current_sprite,
		"modulate:a",
		0.0,
		1.0
	)

	tween.parallel().tween_property(
		next_sprite,
		"modulate:a",
		1.0,
		1.0
	)
	
	tween.finished.connect(_on_crossfade_finished)


func _on_crossfade_finished():
	var temp = current_sprite
	current_sprite = next_sprite
	next_sprite = temp
