extends Node2D

var start_scene = "res://Scène/Tutoriel.tscn"
var current_level : Node2D
var combat : Node2D
var current_allies = ["player"]
@onready var fondu = $Fondu/AnimationPlayer

var allies = { 
	"Frisk" : [20,20,1] 
}

func _ready():
	current_level = load(start_scene).instantiate()
	$Level.add_child(current_level)
	$Player/Camera2D.make_current()
	SignalBus.fight.connect(start_combat)
	SignalBus.victory.connect(combat_won)
	SignalBus.go_to.connect(on_go_to)
	
	
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
	SignalBus.emit_signal("update_FriskUI", allies["Frisk"][0], allies["Frisk"][1], allies["Frisk"][2])
	
func combat_won() :
	allies["Frisk"][1] = $Combat_scene/Ally_group/Combat_player.HP
	await get_tree().create_timer(1.5).timeout
	fondu.play("fondu")
	await fondu.animation_finished
	combat.queue_free()
	$Combat_scene/Camera2D.enabled = false
	$Player/Camera2D.enabled = true
	$Level.visible = true
	fondu.play_backwards("fondu")
	





func on_go_to(location) :
	fondu.play("fondu")
	await fondu.animation_finished
	current_level = load("res://Scène/"+location+".tscn").instantiate()
	$Level.get_child(0).queue_free()
	$Level.add_child(current_level)
	fondu.play_backwards("fondu")
	
