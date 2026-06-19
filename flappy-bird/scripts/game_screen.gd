extends Node2D

var pipe_scene = preload("res://scanes/wall_group.tscn") 
var pipes : Array
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		_delete_pipe()
		
	
func spawn_pipe():
	
	var y_position = randf_range(-470.0, -180.0)
	
	pipes.push_back(pipe_scene.instantiate())
	pipes.back().position = Vector2(650, y_position) 
	
	var tween = get_tree().create_tween()
	tween.tween_property(pipes.back(),"position", Vector2(-700,y_position), 5.0)
	add_child(pipes.back())


func _on_timer_timeout() -> void:
	spawn_pipe()
	print(pipes.size())

func _delete_pipe() -> void:
	print("DELETED")
	
	if(pipes.size() > 0):
		pipes.front().queue_free()
		pipes.pop_front()
