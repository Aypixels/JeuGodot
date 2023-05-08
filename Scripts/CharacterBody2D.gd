extends CharacterBody2D

var speed = 0;
var oldPose = "Down"
var is_body_inside = false


func _physics_process(_delta):
	velocity.x = (int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))) 
	velocity.y = (int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))) 
	velocity = velocity.normalized() * speed
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
		speed = 100
		$AnimatedSprite2D.speed_scale = 1.7
	else:
		speed = 70
		$AnimatedSprite2D.speed_scale = 1

func _on_area_2d_body_entered(_body):
	is_body_inside = true
	var gate = get_parent().get_node("Gate/AnimatedSprite2D")
	gate.play("gate")

func _on_area_2d_body_exited(_body):
	is_body_inside = false
	var gate = get_parent().get_node("Gate/AnimatedSprite2D")
	gate.play_backwards("gate")

func _process(_delta):
	if is_body_inside:
		var gate = get_parent().get_node("Gate/AnimatedSprite2D")
		var collision = get_parent().get_node("Gate/CollisionShape2D")
		var frame = gate.frame
		if frame == 4:
			gate.pause()
			collision.set_deferred("disabled", true)
	else:
		var gate = get_parent().get_node("Gate/AnimatedSprite2D")
		var collision = get_parent().get_node("Gate/CollisionShape2D")
		var frame = gate.frame
		if frame == 0:
			gate.pause()
			collision.set_deferred("disabled", false)
