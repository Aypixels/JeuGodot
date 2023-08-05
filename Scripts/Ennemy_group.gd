extends Node2D

var enemy_path = ""
var enemy_scene : Object
var enemies = []


func _ready():
	SignalBus.fight.connect(place_enemy)
	visible = false
	
func place_enemy(_combat_index, enemies_id) :
	visible = true
	print("signale bien reçu")
	for enemy_id in enemies_id :
		enemy_path = "res://Combat_characters/Combat_"+enemy_id+".tscn"
		enemy_scene = load(enemy_path)
		add_child(enemy_scene.instantiate())
	enemies = get_children()
	print(enemies.size())
	for i in enemies.size():
		enemies[i].position = Vector2(i*32, 0)
