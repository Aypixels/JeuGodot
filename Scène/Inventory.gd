extends Control

@onready var item_list = $Item_inventory/ItemList
@onready var game = $"../.."
@onready var player = $".."



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
	
func close_inventory():
	$Item_inventory/ItemList.deselect_all()
	get_tree().paused = false
	visible = false
	$item_info/stats.text = ""
	$item_info/descriptton.text = ""
	$item_info/item_icon.texture = null
	$item_info/item_icon.scale = Vector2(1,1)
	

func add_item(id) :
	item_inventory.push_back(item_data[id])
	var icon = load(item_data[id][0])
	item_list.add_icon_item(icon)
	for i in range(item_list.item_count) :
		item_list.set_item_selectable(i, true)
	
func lose_item(id):
	item_inventory[id].erase(id)
	item_list.remove_item(id)
	
func show_team() :
	for ally in game.allies.values() :
		var ally_sprite = $Team/team_sprite/ally_sprite.duplicate()
		$Team/team_sprite.add_child(ally_sprite)
		ally_sprite.texture = load(ally[3])
		ally_sprite.position = Vector2((40*ally[2]),50)
		ally_sprite.scale = ally[4]
		if ally_sprite.texture == load("res://Animation/battle_gray_frisk/Idle1.png") :
			ally_sprite.flip_h = true
		else:
			ally_sprite.flip_h = false
		
		

func _on_item_list_item_selected(item_selected):
	$item_info/descriptton.text = item_inventory[item_selected][4]
	if item_inventory[item_selected][1] != 0 or item_inventory[item_selected][2] !=0 or item_inventory[item_selected][3] != 0 :
		$item_info/stats.text = "
		ATK +"+ str(item_inventory[item_selected][1])+"
		DEF +"+ str(item_inventory[item_selected][2])+"
		HP +"+ str(item_inventory[item_selected][3])
	$item_info/item_icon.texture = load(item_inventory[item_selected][0])
	$item_info/item_icon.scale = item_inventory[item_selected][5]

