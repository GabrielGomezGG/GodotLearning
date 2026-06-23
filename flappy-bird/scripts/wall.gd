extends Area2D

@export var isVisible : bool = true
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	if isVisible:
		sprite_2d.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		sprite_2d.modulate = Color(1.0, 1.0, 1.0, 0.0)
