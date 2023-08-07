extends CharacterBody2D

@onready var _focus = $focus
@onready var animation_player = $AnimatedSprite2D
var hurt = false


func _ready():
	$AnimatedSprite2D.play("walk")
	
var Max_health : int = 20
var ATK = 5
var HP : int = 20 

func _update_health() :
	pass

func _play_animation() :
	animation_player.play("hurt")
	hurt = true
	
func focus() :
	_focus.show()
	
func unfocus():
	_focus.hide()
	
func take_damage(value):
	HP -= value
	_update_health()
	_play_animation()

func _process(_delta):
	if hurt == true and animation_player.frame == 4 :
		animation_player.play("walk")
		hurt = false
