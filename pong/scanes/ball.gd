class_name Ball
extends CharacterBody2D

signal set_point(orientation: int)
signal change_turn
signal colission

const MIN_VELOSITY_BALL : float = 200.0

static var velosity_ball : float = 200.0
static var counter : int = 1
@export var orientation_x : int = 1
@export var orientation_y : int = 1

@export var camera : Camera2D

static var MAX_HEIGHT_SIZE : float = 0

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	orientation_x = randomOrientation()
	orientation_y = randomOrientation()
	MAX_HEIGHT_SIZE = camera.get_viewport().get_visible_rect().size.y
	
	print(MAX_HEIGHT_SIZE)
	
	velocity = Vector2(1, 0.5).normalized() * velosity_ball

func randomOrientation() -> int:
	var orientation = randi() % 2
	var result = 1 
	match orientation:
		0: result = 1
		1: result = -1
	
	return result

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += (velosity_ball * delta) * orientation_x
	position.y += (velosity_ball * delta) * orientation_y


func _on_area_2d_body_entered(body: Node2D) -> void:
	velosity_ball += 50
	counter += 1
	
	colission.emit()
	
	match body.collision_layer:
		1: # Player Colision
			orientation_x *= -1
			cpu_particles_2d.gravity *= -(1)
			cpu_particles_2d.amount += 4
			change_turn.emit()
		2: # Wall Colision
			orientation_y *= -1
		8: # Point Colision
			counter = 1
			position = Vector2(0.0,_get_ramdom_height())
			velosity_ball = MIN_VELOSITY_BALL
			set_point.emit(orientation_x)
			cpu_particles_2d.amount = 4

func _get_ramdom_height() -> float:
	var halfHeight = (MAX_HEIGHT_SIZE) / 3
	return randf_range(halfHeight * -1, halfHeight) 

func _on_screen_star_game(isPlayerOneTurn: bool) -> void:
	
	var orientation = 1 
	if isPlayerOneTurn: orientation = 1 
	else: orientation = -1
	
	orientation_x = orientation
