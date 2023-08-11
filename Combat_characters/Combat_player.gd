extends Node2D

@onready var _focus = $focus
@onready var damage_taken = $damage_taken


var ATK = 5
var Max_health : int = 20
var LV : int = 1
var HP : int = 20
		
func _update_health() :
	SignalBus.emit_signal("update_FriskUI", Max_health, HP, LV )

func _play_animation() :
	$AnimationPlayer.play("hurt")
	
func focus() :
	_focus.show()
func unfocus():
	_focus.hide()
	
func take_damage(value):
	HP -= value
	if HP > 0 :
		damage_taken.play()
		_update_health()
		_play_animation()
	else :
		_defeated()
	
func _ready():
	$AnimatedSprite2D.play("idleLeft")
	SignalBus.update_FriskUI.connect(get_stats)
	
func get_stats(Maxhp, current_hp, lvl) :
	Max_health = Maxhp
	HP = current_hp
	LV = lvl
	
	
func _defeated() :
	SignalBus.emit_signal("defeated", $".")
	visible = false
	
	

