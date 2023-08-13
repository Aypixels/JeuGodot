extends Node2D

var start_scene = "res://Scène/Tutoriel.tscn"
var current_level : Node2D
var combat : Node2D
var current_allies = ["player"]
@onready var fondu = $Fondu/AnimationPlayer

#[Maxhp, hp, Lv] ,  item_equipped(0 : weapon/ 1 : armor/2: accessory : [ATK,DEF,HP, special effect], position, sprite_path,scale
var allies = {
	"Frisk" : [[20,20,1],
		[null,null,null],
		1,
		"res://Animation/battle_gray_frisk/Idle1.png",
		Vector2(3.3,3.226)]
}

func _ready():
	SignalBus.emit_signal("location", "Dream")
	current_level = load(start_scene).instantiate()
	$Level.add_child(current_level)
	$Player/Camera2D.make_current()
	SignalBus.fight.connect(start_combat)
	SignalBus.victory.connect(combat_won)
	SignalBus.go_to.connect(on_go_to)
	SignalBus.lose.connect(combat_lost)
	
	
func start_combat(combat_index, enemies) :
	$"Engage".play()
	$Level.visible = false
	await get_tree().create_timer(0.1).timeout
	$Level.visible = true
	await get_tree().create_timer(0.1).timeout
	$Level.visible = false
	await get_tree().create_timer(0.1).timeout
	$Level.visible = true
	await get_tree().create_timer(0.1).timeout
	$Level.visible = false
	await get_tree().create_timer(0.6).timeout
	combat = load("res://Scène/Combat_scene.tscn").instantiate()
	add_child(combat)
	$Player/Camera2D.enabled = false
	$Combat_scene/Camera2D.enabled = true
	$Level.visible = false
	SignalBus.emit_signal("place_combat", combat_index, enemies, current_allies)
	SignalBus.emit_signal("update_FriskUI", allies["Frisk"][0][0], allies["Frisk"][0][1], allies["Frisk"][0][2])
	
func combat_won() :
	allies["Frisk"][0][1] = $Combat_scene/Ally_group/Combat_player.HP
	await get_tree().create_timer(1.5).timeout
	fondu.play("fondu")
	await fondu.animation_finished
	fondu.play_backwards("fondu")
	combat.queue_free()
	$Player/Camera2D.enabled = true
	$Level.visible = true

	

func combat_lost() :
	await get_tree().create_timer(0.7).timeout
	SignalBus.emit_signal("go_to", "chamber")
	await fondu.animation_finished
	SignalBus.emit_signal("location", "Overworld")
	combat.queue_free()
	$Player/Camera2D.enabled = true
	$Level.visible = true
	

func on_go_to(location) :
	fondu.play("fondu")
	await fondu.animation_finished
	fondu.play_backwards("fondu")
	current_level = load("res://Scène/"+location+".tscn").instantiate()
	$Level.get_child(0).queue_free()
	$Level.add_child(current_level)
	
