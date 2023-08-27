extends Control

@onready var item_list = $Item_inventory/ItemList
@onready var game = $"../.."
@onready var player = $".."
@onready var equiper = $item_info/Equiper
@onready var jeter = $item_info/Jeter


var current_selected = 0
var equipping = false
# nom de l'item : path, stats(ATK,DEF,HP), description, scale , type, special effect
var item_inventory = []
var item_data = {
	"bâton" : ["res://assets/Items/stick_sprite.png", 1,0,0 , "Un bâton :
simple mais solide. Attention à ne pas le casser !", Vector2(0.3, 0.2999) , "weapon", null]
}


func _ready(): 
	visible = false
	add_item("bâton")

func _process(_delta):
	if Input.is_action_just_pressed("open_inventory") and player._location != "Overworld" and player.in_dialog() == false  :
		if visible == true :
			close_inventory()
		else :
			open_inventory()
		
		
func open_inventory() :
	SignalBus.emit_signal("update_FriskUI", game.allies["Frisk"][0][0], game.allies["Frisk"][0][1], game.allies["Frisk"][0][2])
	get_tree().paused = true
	visible = true
	show_team()
	current_selected = 0
	
func close_inventory():
	$Item_inventory/ItemList.deselect_all()
	
	get_tree().paused = false
	visible = false
	
	hide_team()
	$item_info/stats.text = ""
	$item_info/descriptton.text = ""
	$item_info/item_icon.texture = null
	$item_info/item_icon.scale = Vector2(1,1)
	equiper.visible = false
	jeter.visible = false
	equipping = false
	

func add_item(id) :
	item_inventory.push_back(item_data[id])
	var icon = load(item_data[id][0])
	item_list.add_icon_item(icon)


func hide_team() :
	for ally in $Team/team_sprite.get_children() :
		ally.queue_free()
	finished_equip()
	
func show_team() :
	for ally in game.allies.values() :
		var ally_sprite = $Team/ally_sprite.duplicate()
		$Team/team_sprite.add_child(ally_sprite)
		ally_sprite.texture = load(ally[3])
		ally_sprite.position = Vector2((45*ally[2]),60)
		ally_sprite.scale = ally[4]
		ally_sprite.visible = true
		#Ajustement sprite de Frisk
		if ally_sprite.texture == load("res://Animation/battle_gray_frisk/Idle1.png") :
			ally_sprite.flip_h = true
		else:
			ally_sprite.flip_h = false


func _on_item_list_item_selected(item_selected):
	current_selected = item_selected
	$item_info/descriptton.text = item_inventory[item_selected][4]
	if item_inventory[item_selected][1] != 0 or item_inventory[item_selected][2] !=0 or item_inventory[item_selected][3] != 0 :
		$item_info/stats.text = "
		ATK +"+ str(item_inventory[item_selected][1])+"
		DEF +"+ str(item_inventory[item_selected][2])+"
		HP +"+ str(item_inventory[item_selected][3])
		equiper.visible = true
	else :
		equiper.visible = false
	jeter.visible=true
	$item_info/item_icon.texture = load(item_inventory[item_selected][0])
	$item_info/item_icon.scale = item_inventory[item_selected][5]


func _on_jeter_pressed():
	if not equipping :
		item_inventory[current_selected].erase(current_selected)
		item_list.remove_item(current_selected)
		$item_info/stats.text = ""
		$item_info/descriptton.text = ""
		$item_info/item_icon.texture = null
		$item_info/item_icon.scale = Vector2(1,1)


func _on_equiper_pressed():
	if not equipping :
		equipping = true
		var count = 0
		for ally_sprite in $Team/team_sprite.get_children() :
			var equipping_ally = $Team.get_child(count)
			equipping_ally.visible = true
			count +=1

func equip_ally(id) :
	for ally in game.allies.values() :
		if ally[2] == id :
			var item_sprite = load(item_inventory[current_selected][0])
			var what = null
			if item_inventory[id-1][6] == "weapon" :
				ally[1][0] = [item_inventory[id-1][1],item_inventory[id-1][2],item_inventory[id-1][3] , null]
				what = 0
			elif item_inventory[id-1][6] == "armor":
				ally[1][1] = [item_inventory[id-1][1],item_inventory[id-1][2],item_inventory[id-1][3] , null]
				what =1
			elif item_inventory[id-1][6] == "accessory":
				ally[1][2] = [item_inventory[id-1][1],item_inventory[id-1][2],item_inventory[id-1][3] , null]
				what = 2
			
			$Team.get_child(-id).get_child(what).texture = item_sprite
			var _is = $Team.get_child(-id).get_child(what).get_texture().get_size() #image size
			var th = 60 #target height
			var tw = 60 #target width
			var _scale = Vector2((_is.x/(_is.x/tw))/50, (_is.y/(_is.y/th))/50)
			$Team.get_child(-id).get_child(what).set_scale(_scale)
			finished_equip()

func _on_equiper_ally_1_pressed(): equip_ally(1)
func _on_equiper_ally_2_pressed(): equip_ally(2)
func _on_equiper_ally_3_pressed(): equip_ally(3)
func _on_equiper_ally_4_pressed(): equip_ally(4)



func finished_equip() :
	$Team/equiper_ally1.visible = false
	$Team/equiper_ally2.visible = false
	$Team/equiper_ally3.visible = false
	$Team/equiper_ally4.visible = false

		
