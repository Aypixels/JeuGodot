extends Node2D

var enemy_path = ""
var enemies = []
var index :int = 0
var select_target = false
var action_queue = []
var is_battling = false



func _ready():
	SignalBus.place_combat.connect(place_enemy)
	visible = false
	
func place_enemy(_combat_index, enemies_id, _allies_id) :
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
			
			
func _process(_delta):
	if select_target :
		if Input.is_action_just_pressed("ui_left"):
			if index > 0:
				index -= 1
				switch_focus(index, index+1)
 
		if Input.is_action_just_pressed("ui_right"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index, index - 1)
				
	if Input.is_action_just_pressed("ui_accept") :
		enemies[index].take_damage(4)

func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()
