extends CharacterBody2D

var speed = 0
var oldPose = "Down"
var stop = false
var locations = {
	"castle" = Vector2(0,0),
	"chamber" = Vector2(0,0)
}

func player():
	pass

func _ready() :
	position.x = 525
	position.y = 430
	SignalBus.memory.connect(memory)
	SignalBus.end_road.connect(end_of_road)
	SignalBus.victory.connect(combat_end)
	SignalBus.go_to.connect(positionning)

func _physics_process(_delta):
	if not stop :
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
		else:
			$AnimatedSprite2D.play("idle" + oldPose)
		move_and_slide()
		
		if Input.is_action_pressed("Shift"):
			speed = 100
			$AnimatedSprite2D.speed_scale = 1.7
		else:
			speed = 70
			$AnimatedSprite2D.speed_scale = 1


func end_of_road():
	stop = true
	$AnimatedSprite2D.play("idleUp")
	

func positionning(location) :
	await get_tree().create_timer(0.8).timeout
	position = locations[location]

func memory():
	stop = true
	$AnimatedSprite2D.play("idleUp")
	SignalBus.emit_signal("dialog_display", "memory")
	stop = false

func combat_end():
	stop = false
