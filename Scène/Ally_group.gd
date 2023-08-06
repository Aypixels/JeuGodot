extends Node2D

var ally_path = ""
var allies = []
var index = 0

func _ready():
	SignalBus.place_combat.connect(place_ally)
	visible = false
	
func place_ally(_combat_index, _enemies_id, allies_id) :
	visible = true
	for ally_id in allies_id :
		ally_path = "res://Combat_characters/Combat_"+ally_id+".tscn"
		var ally_scene = load(ally_path)
		var ally = ally_scene.instantiate()
		add_child(ally)
	allies = get_children()
	if allies.size() == 1 :
		allies[0].position = Vector2(36,0)
	else :
		for i in allies.size():
			allies[i].position = Vector2(i*20+16, 0)
	allies[0].focus()


func _on_ennemy_group_next_player():
	if index < allies.size() - 1:
		index += 1
		switch_focus(index, index - 1)
	else:
		index = 0
		allies[-1].unfocus()
		

func _on_ennemy_group_new_turn():
	allies[0].focus()
	
	
func switch_focus(x,y):
	allies[x].focus()
	allies[y].unfocus()
	
