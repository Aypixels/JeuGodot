extends CharacterBody2D

var speed = 0
var oldPose = "Down"
var stop = false
var locations = {
	"wrap_zone_Tutoriel" = Vector2(0,0),
	"chamber_wrap_zone" = Vector2(-19,-12),
	"omori_start_wrap_zone" = Vector2(0,0),
	"deltarune_start_wrap_zone" =Vector2(0,0),
	"oneshot_start_wrap_zone" =Vector2(0,0),
	"hallway_chamber" = Vector2(-135, 17),
	"chamber_hallway" = Vector2(-85, 50)
}

var _location

func player():
	pass

func _ready() :
	position.x = 670
	position.y = 460
	SignalBus.memory.connect(memory)
	SignalBus.end_road.connect(end_of_road)
	SignalBus.victory.connect(combat_end)
	SignalBus.go_to.connect(positionning)
	SignalBus.location.connect(locate_frisk)
	SignalBus.show_spacebar.connect(show_spacebar)
	SignalBus.hide_spacebar.connect(hide_spacebar)

func _physics_process(_delta):
	if not stop :
		velocity.x = (int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))) 
		velocity.y = (int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))) 
		velocity = velocity.normalized() * speed
		if Input.is_action_pressed("Right"):
			$AnimatedSprite2D.play("right" + _location)
			oldPose = "Right"
		elif Input.is_action_pressed("Left"):
			$AnimatedSprite2D.play("left" + _location)
			oldPose = "Left"
		elif Input.is_action_pressed("up"):
			$AnimatedSprite2D.play("up" + _location)
			oldPose = "Up"
		elif Input.is_action_pressed("down"):
			$AnimatedSprite2D.play("down" + _location)
			oldPose = "Down"
		else:
			go_idle()
		move_and_slide()
		
		if Input.is_action_pressed("Shift"):
			speed = 100
			$AnimatedSprite2D.speed_scale = 1.7
		else:
			speed = 70
			$AnimatedSprite2D.speed_scale = 1


func end_of_road():
	stop = true
	$AnimatedSprite2D.play("idleUp" + _location)
	

func positionning(location, transition, from) :
	stop = true
	$AnimatedSprite2D.play("idle" + oldPose + _location)
	if transition :
		await get_tree().create_timer(1).timeout
	position = locations[location+"_"+from]
	stop = false

func memory():
	stop = true
	$AnimatedSprite2D.play("idleUp" + _location)
	SignalBus.emit_signal("dialog_display", "memory")
	stop = false

func combat_end():
	stop = false

func locate_frisk(location):
	_location = location
	oldPose = "Down"
	go_idle()
	
func go_idle() : $AnimatedSprite2D.play("idle" + oldPose + _location)
func get_cam_pos(): return $Camera2D.position
func camera_stop() : $Camera2D.enabled = false
func camera_recover() : $Camera2D.enabled = true
func in_dialog() : return $Control/Dialogbox2.visible


func show_spacebar(): 
	$Spacebar.visible = true
	$Spacebar.play("spacebar")
func hide_spacebar(): 
	$Spacebar.visible = false
	$Spacebar.stop()
