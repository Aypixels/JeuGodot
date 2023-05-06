extends CharacterBody2D

var speed = 100
var oldPose = ""

func _physics_process(_delta):
	velocity.x = (int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))) * speed
	velocity.y = (int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))) * speed
	move_and_slide()
	
	if Input.is_action_pressed("Right"):
		$AnimatedSprite2D.play("right")
		oldPose = "Right"
	elif Input.is_action_pressed("Left"):
		$AnimatedSprite2D.play("left")
		oldPose = "Left"
	elif Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("up")
		oldPose = "Up"
	elif Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("down")
		oldPose = "Down"
	else:
		$AnimatedSprite2D.play("idle" + oldPose)
	
	if Input.is_action_pressed("Shift"):
		speed = 150
		$AnimatedSprite2D.speed_scale = 2
	else:
		speed = 100
