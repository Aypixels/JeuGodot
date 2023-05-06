extends CharacterBody2D

@export var speed = 100
@export var jump_speed = 300
@export var gravity = 20

func _physics_process(_delta):
	if Input.is_action_pressed("Shift"):
		speed = 200
		$Sprite2D.speed_scale = 4
	else :
		speed = 100
		$Sprite2D.speed_scale = 2
	velocity.x = (int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))) * speed
	
	velocity.y += gravity
	move_and_slide()
	if is_on_floor():
		if Input.is_action_pressed("Right"):
			$Sprite2D.flip_h = false
			$Sprite2D.play("run")
		elif Input.is_action_pressed("Left"):
			$Sprite2D.flip_h = true
			$Sprite2D.play("run")
		else:
			$Sprite2D.play("idle")
		if Input.is_action_pressed("Jump") :
			velocity.y = -jump_speed
	else :
		if Input.is_action_pressed("Right"):
			$Sprite2D.flip_h = false
		elif Input.is_action_pressed("Left"):
			$Sprite2D.flip_h = true
		if velocity.y < 0 :
			$Sprite2D.play("jump")
		else : 
			$Sprite2D.play("fall")
		
		
		
