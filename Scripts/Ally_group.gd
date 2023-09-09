extends Node2D

@onready var e_group = $"../Ennemy_group"

var ally_path = ""
var allies = []
var enemies = []
var index = 0
var specials = []


func _ready():
	SignalBus.place_combat.connect(place_ally)
	SignalBus.enemy_attack.connect(receive_dmg)
	SignalBus.new_turn.connect(focus_first)
	SignalBus.defeated.connect(allly_defeated)
	visible = false
	
func place_ally(_combat_index, enemies_id, allies_id) :
	enemies = enemies_id
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
		

func focus_first():
	if allies.size()>0 :
		allies[0].focus()
	
	
func switch_focus(x,y):
	allies[x].focus()
	allies[y].unfocus()
	
func receive_dmg(DMG):
	for ally in allies :
		if ally.HP > 0:
			ally.take_damage(DMG)
			break
		
		
func allly_defeated(ally_id) :
	if ally_id in allies :
		allies.erase(ally_id)

func current_ally_atk() :
	return allies[index].ATK
	

func _on_run_pressed():
	hide_specials()
	if enemies[0] == "something" :
		SignalBus.emit_signal("battle_dialog_display", "something_run")

func _on_special_pressed():
	hide_specials()
	SignalBus.emit_signal("battle_dialog_display", "clear")
	var ally = get_child(index)
	$"../select_special".show()
	$"../choice".current = $"../select_special/Special1"
	$"../choice".current.grab_focus()
	var button_index = 0
	specials = []
	for special in ally.specials :
		var button = $"../select_special".get_child(button_index)
		button.show()
		button.text = special["name"]
		specials.append({"action" : special["action"],"select?" : special["select?"]})
		button_index +=1
		
func hide_specials():
	for button in $"../select_special".get_children():
		button.text = ""
		button.hide()
	
func use_special(id) :
	var target = null
	if specials[id]["select?"] :
		e_group.choice.hide()
		e_group.action = "special"
		e_group.start_choosing()
		await e_group.finished_choosing
		target = e_group.get_child(e_group.target_index)
	get_child(index).call(specials[id]["action"], target)
	
func special_finished():
	e_group.reset_focus()
	e_group.emit_signal("next_player")
	e_group.action = ""
	e_group.action_queue.push_back([e_group.target_index, 0 , e_group.action])

func _on_special_1_pressed():
	use_special(0)
	$"../select_special/Special1".hide()
	$"../select_special/Special1".text = ""
func _on_special_2_pressed():
	use_special(1)
	$"../select_special/Special2".hide()
	$"../select_special/Special2".text = ""
func _on_special_3_pressed():
	use_special(2)
	$"../select_special/Special3".hide()
	$"../select_special/Special3".text = ""
func _on_special_4_pressed():
	use_special(3)
	$"../select_special/Special4".hide()
	$"../select_special/Special4".text = ""
