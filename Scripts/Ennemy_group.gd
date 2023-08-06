extends Node2D

var enemy_path = ""
var enemies = []


func _ready():
	SignalBus.place_combat.connect(place_enemy)
	visible = false
	
func place_enemy(_combat_index, enemies_id) :
	visible = true
	for enemy_id in enemies_id :
		enemy_path = "res://Combat_characters/Combat_"+enemy_id+".tscn"
		var enemy_scene = load(enemy_path)
		var enemy = enemy_scene.instantiate()
		add_child(enemy)
	enemies = get_children()
	if enemies.size() == 1 :
		enemies[0].position = Vector2(-45,0)
	else :
		for i in enemies.size():
			enemies[i].position = Vector2(i*-20-16, 0)
