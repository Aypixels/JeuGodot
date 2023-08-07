extends CharacterBody2D

@onready var defeated = $defeated
@onready var _focus = $focus
@onready var animation_player = $AnimatedSprite2D
var hurt = false


func _ready():
	$AnimatedSprite2D.play("walk")
	
var Max_health : int = 20
var ATK = 5
var HP : int = 20 


func _play_animation() :
	animation_player.play("hurt")
	hurt = true
	
func focus() :
	_focus.show()
	
func unfocus():
	_focus.hide()
	
func take_damage(value):
	HP -= value
	if HP < 1 : 
		_defeated()
	else:
		_play_animation()

func _process(_delta):
	if hurt == true and animation_player.frame == 4 :
		animation_player.play("walk")
		hurt = false
	if animation_player.frame == 15 and HP < 1:
		visible = false


func _defeated() :
	SignalBus.emit_signal("defeated", $".")
	defeated.play()
	animation_player.play("disappear")

