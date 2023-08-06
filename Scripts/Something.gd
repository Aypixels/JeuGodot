extends CharacterBody2D

var launch = false

func _ready():
	$AnimatedSprite2D.visible=false
	SignalBus.end_road.connect(on_end_road)
	
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



