extends Node2D

var start_scene = "res://Scène/Tutoriel.tscn"
var current_level : Node2D
var combat : Node2D

func _ready():
	current_level = load(start_scene).instantiate()
	$Level.add_child(current_level)
	$Player/Camera2D.make_current()
	SignalBus.fight.connect(start_combat)
	
	
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
	SignalBus.emit_signal("place_combat", combat_index, enemies)
	
	
	
	
