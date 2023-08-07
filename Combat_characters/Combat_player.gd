extends Node2D

@onready var _focus = $focus
@onready var damage_taken = $damage_taken


var ATK
var Max_health : int = 0
var LV : int = 0
var HP : int = 0 
		
func _update_health() :
	SignalBus.emit_signal("update_FriskUI", Max_health, HP, LV )

func _play_animation() :
	$AnimationPlayer.play("hurt")
	
func focus() :
	_focus.show()
func unfocus():
	_focus.hide()
	
func take_damage(value):
	damage_taken.play()
	HP -= value
	_update_health()
	_play_animation()
	
func _ready():
	$AnimatedSprite2D.play("idleLeft")
	SignalBus.update_FriskUI.connect(get_stats)
	
func get_stats(Maxhp, current_hp, lvl) :
	Max_health = Maxhp
	HP = current_hp
	LV = lvl
	
	
	

