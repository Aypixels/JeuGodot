extends CharacterBody2D

var launch = false

func _ready():
	$AnimatedSprite2D.visible=false
	SignalBus.end_road.connect(on_end_road)
	SignalBus.victory.connect(combat_end)
	
func on_end_road() :
	$AnimatedSprite2D.visible = true
	launch = true
	$AnimatedSprite2D.play("appear")
	
func _process(_delta) :
	if launch == true:
		if $AnimatedSprite2D.frame == 10 :
			$AnimatedSprite2D.play("walk")
			SignalBus.emit_signal("fight", "something", ["something"])
			launch = false

func combat_end():
	SignalBus.emit_signal("battle_dialog_display", "win_something")
	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$"../End_of_road/CollisionShape2D".set_deferred("disabled", true)

