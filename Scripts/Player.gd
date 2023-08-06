extends CharacterBody2D

var speed = 0
var oldPose = "Down"
var attacking = true
var stop = false

func player():
	pass

func _ready() :
	position.x = 525
	position.y = 430
	SignalBus.end_road.connect(end_of_road)

func _physics_process(_delta):
	if not stop :
		if $AnimatedSprite2D.animation_finished:
			attacking = false
		velocity.x = (int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))) 
		velocity.y = (int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))) 
		velocity = velocity.normalized() * speed
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
		elif Input.is_action_pressed("attack") and not attacking:
			$AnimatedSprite2D.play("attack_"+oldPose)
			attacking = true
			print("attack")
		else:
			$AnimatedSprite2D.play("idle" + oldPose)
		if attacking == false :
			move_and_slide()
		if Input.is_action_pressed("Shift"):
			speed = 100
			$AnimatedSprite2D.speed_scale = 1.7
		else:
			if attacking :
				$AnimatedSprite2D.speed_scale = 1.7
			else:
				speed = 70
				$AnimatedSprite2D.speed_scale = 1


func end_of_road():
	stop = true
	$AnimatedSprite2D.play("idleUp")
