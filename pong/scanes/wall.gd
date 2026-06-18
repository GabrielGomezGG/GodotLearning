extends StaticBody2D

@export var color : Color
@onready var color_rect: ColorRect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.color = color
