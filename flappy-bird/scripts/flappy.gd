class_name Flappy

extends CharacterBody2D

signal game_over
signal set_point

var GRAVITY = 1000.0
const JUMP_FORCE = -400.0
@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

var tweenJump : Tween

func _ready() -> void:
	animated_sprite_2d.play()
	GRAVITY = 1000.0
	area_2d.monitoring = true
	area_2d.monitorable = true


func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if GameScreen.gameOver:
		gameOverAnimation()
	else:
		if Input.is_action_just_pressed("jump"):
			jumpAnimation()
		
	move_and_slide()

func gameOverAnimation():
	#self.rotation = 180.0
	timer.stop()
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "rotation_degrees", -180, 0.1)
	GRAVITY *= 1.1
	
func jumpAnimation():
	velocity.y = JUMP_FORCE
	#var tween = create_tween()
	if tweenJump:
		tweenJump.kill()
	
	tweenJump = create_tween()
	
	tweenJump.tween_property(animated_sprite_2d, "rotation_degrees", -35, 0.3)
	timer.wait_time = 0.3

func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "rotation_degrees", +45, 0.8)


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "HitboxPoint":
		set_point.emit()
	else:
		area_2d.queue_free()
		game_over.emit()
