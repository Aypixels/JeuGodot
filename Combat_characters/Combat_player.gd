extends Node2D

@onready var _focus = $focus
@onready var animation_player = $AnimationPlayer

var Max_health : int = 20

var health : int = 20 :
	set(value) :
		health = value
		_update_health()
		_play_animation()
		
func _update_health() :
	pass

func _play_animation() :
	animation_player.play("hurt")
	
func focus() :
	_focus.show()
func unfocus():
	_focus.hide()
	
func take_damage(value):
	health -= value
	
func _ready():
	$AnimatedSprite2D.play("idleLeft")
