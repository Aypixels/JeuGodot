extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.visible=false
	SignalBus.end_road.connect(on_end_road)
	
func on_end_road() :
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play_backwards("disappear")
		
func _process(_delta) :
	if $AnimatedSprite2D.frame == 0:
		$AnimatedSprite2D.play("walk")
