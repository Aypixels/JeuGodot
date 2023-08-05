extends CharacterBody2D

var speed = 0
var oldPose = "Down"
var is_body_inside = false
var attacking = true
var stop = false

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

func _on_area_2d_body_entered(body):
	if body == $"." :
		is_body_inside = true
		var gate = get_parent().get_node("Gate/AnimatedSprite2D")
		gate.play("gate")

func _on_area_2d_body_exited(body):
	if body == $"." :
		is_body_inside = false
		var gate = get_parent().get_node("Gate/AnimatedSprite2D")
		gate.play_backwards("gate")

func _process(_delta):
	if SignalBus.current_scene == "Tutoriel" :
		var gate = get_parent().get_node("Gate/AnimatedSprite2D")
		var gate_collision = get_parent().get_node("Gate/CollisionShape2D")
		if is_body_inside:
			if gate.frame == 4:
				gate.pause()
				gate_collision.set_deferred("disabled", true)
		else:
			if gate.frame == 0:
				gate.pause()
				gate_collision.set_deferred("disabled", false)


func _on_end_of_road_body_entered(body):
	if body == $".":
		stop = true
		$AnimatedSprite2D.play("idleUp")
		SignalBus.emit_signal("end_road")
