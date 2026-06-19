class_name Flappy

extends CharacterBody2D

const GRAVITY = 1000.0
const JUMP_FORCE = -350.0
@onready var timer: Timer = $Timer


func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", -45, 0.3)
		timer.wait_time = 0.3
		
	move_and_slide()


func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", +70, 0.6)
