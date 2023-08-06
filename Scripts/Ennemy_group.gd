extends Node2D

var number_of_allies = 0
var enemies = []
var target_index :int = 0
var action_queue = []
var is_battling = false
@onready var choice = $"../choice"

signal next_player
signal new_turn


func _ready():
	SignalBus.place_combat.connect(place_enemy)
	visible = false
	
func place_enemy(_combat_index, enemies_id, allies_id) :
	number_of_allies = allies_id.size()
	visible = true
	for enemy_id in enemies_id :
		var enemy_path = "res://Combat_characters/Combat_"+enemy_id+".tscn"
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
	if not choice.visible :
		if Input.is_action_just_pressed("ui_left"):
			if target_index > 0:
				target_index -= 1
				switch_focus(target_index, target_index+1)
		if Input.is_action_just_pressed("ui_right"):
			if target_index < enemies.size() - 1:
				target_index += 1
				switch_focus(target_index, target_index - 1)
				
		if Input.is_action_just_pressed("ui_accept") :
			action_queue.push_back(target_index)
			reset_focus()
			emit_signal("next_player")
		
	if action_queue.size() == number_of_allies and not is_battling :
		is_battling = true
		_action(action_queue)

func _action(stack) :
	for i in stack :
		enemies[i].take_damage(1)
		await get_tree().create_timer(1).timeout
	action_queue.clear()
	is_battling = false
	emit_signal("new_turn")
	show_choice()

func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()

func show_choice():
	choice.show()
	
func reset_focus():
	target_index = 0
	for enemy in enemies:
		enemy.unfocus()
		
func start_choosing() :
	reset_focus()
	enemies[0].focus()

func _on_attack_pressed():
	choice.hide()
	start_choosing()
