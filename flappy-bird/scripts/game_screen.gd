class_name GameScreen
extends Node2D

signal update_score(text: String)

var pipe_scene = preload("res://scanes/wall_group.tscn") 
var pipes : Array
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@export var parallax2D : Parallax2D

var score: int = 0
static var gameOver = false
var tweenPipes : Array[Tween]

func _ready() -> void:
	parallax2D.autoscroll.x = -200

func _physics_process(delta: float) -> void:
	
	if ray_cast_2d.is_colliding():
		_delete_pipe()
		
	
func spawn_pipe():
	if gameOver:
		return
		
	var y_position = randf_range(-470.0, -180.0)
	
	pipes.push_back(pipe_scene.instantiate())
	pipes.back().position = Vector2(650, y_position) 
	
	tweenPipes.push_back(create_tween())
	
	tweenPipes.back().tween_property(pipes.back(),"position", Vector2(-700,y_position), 5.0)
	add_child(pipes.back())


func _on_timer_timeout() -> void:
	spawn_pipe()

func _delete_pipe() -> void:
	
	if(pipes.size() > 2):
		pipes.front().queue_free()
		pipes.pop_front()

func setPoint() -> void:
	print("POINT: " + str(score))
	score += 1
	update_score.emit(str(score))

func _on_wall_group_set_point() -> void:
	print("POINT: " + str(score))
	score += 1
	update_score.emit(str(score))


func _on_flappy_game_over() -> void:
	print("GAME OVER")
	gameOver = true
	parallax2D.autoscroll.x = 0
	
	for pipe in tweenPipes:
		if pipe: pipe.kill()


func _on_game_ui_reset_game() -> void:
	gameOver = false
	score = 0
	
	get_tree().change_scene_to_file("res://scanes/game_screen.tscn")


func _on_flappy_set_point() -> void:
	setPoint()
