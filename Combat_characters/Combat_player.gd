extends Node2D

@onready var _focus = $focus
@onready var damage_taken = $damage_taken
@onready var game = $"../../.."

var ATK = 5
var DEF = 0
var Max_health : int = 20
var LV : int = 1
var HP : int = 20
		
func _update_health() :
	SignalBus.emit_signal("update_FriskUI", Max_health, HP, LV )

func _play_animation() :
	$AnimationPlayer.play("hurt")
	await $AnimationPlayer.animation_finished
	$AnimatedSprite2D.play("idle")
	
func focus() :
	_focus.show()
func unfocus():
	_focus.hide()
	
func take_damage(value):
	HP -= value-DEF
	_update_health()
	damage_taken.play()
	if HP > 0 :
		_play_animation()
	else :
		_defeated()
	
func _ready():
	$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("idle")
	SignalBus.update_FriskUI.connect(get_stats)
	
func get_stats(Maxhp, current_hp, lvl) :
	Max_health = Maxhp
	HP = current_hp
	LV = lvl
	ATK = 5
	DEF = 0
	var items = game.allies["Frisk"][1]
	for item in items :
		ATK += item[0]
		DEF += item[1]
	
	
func _defeated() :
	$AnimatedSprite2D.flip_h = false
	$AnimatedSprite2D.play("death")
	SignalBus.emit_signal("defeated", $".")
	await $AnimatedSprite2D.animation_finished
	visible = false
	

