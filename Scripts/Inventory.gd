extends Control

@onready var item_list = $Item_inventory/ItemList
@onready var game = $"../.."
@onready var player = $".."
@onready var equiper = $item_info/Equiper
@onready var jeter = $item_info/Jeter


var current_selected = 0
var equipping = false
# nom de l'item : path, stats(ATK,DEF,HP), description, scale ,special effect
var item_inventory = []
var item_data = {
	"bâton" : ["res://assets/Items/stick_sprite.png", 1,0,0 , "Un bâton :
simple mais solide. Attention à ne pas le casser !", Vector2(0.3, 0.2999) , null]
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
	equiper.visible=false
	jeter.visible=false
	current_selected = 0
	equipping = false
	
func close_inventory():
	$Item_inventory/ItemList.deselect_all()
	get_tree().paused = false
	visible = false
	$item_info/stats.text = ""
	$item_info/descriptton.text = ""
	$item_info/item_icon.texture = null
	$item_info/item_icon.scale = Vector2(1,1)
	equiper.visible = false
	jeter.visible = false
	

func add_item(id) :
	item_inventory.push_back(item_data[id])
	var icon = load(item_data[id][0])
	item_list.add_icon_item(icon)
	for i in range(item_list.item_count) :
		item_list.set_item_selectable(i, true)
	

	
func show_team() :
	for ally in game.allies.values() :
		var ally_sprite = $Team/team_sprite/ally_sprite.duplicate()
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
		for ally_sprite in $Team/team_sprite.get_children() :
			var equip_ally = ally_sprite.get_child(0)
			equip_ally.position.x = ally_sprite.position.x 
			equip_ally.position.y = ally_sprite.position.y
			equip_ally.visible = true
