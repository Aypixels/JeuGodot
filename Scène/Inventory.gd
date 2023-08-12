extends Control
@onready var item_list = $Item_inventory/ItemList

# nom de l'item : path, stats(ATK,DEF,HP), description 
var item_inventory = []
var item_data = {
	"baton" : ["res://assets/Items/stick_sprite.png", 1,0,0 , "Un bâton :
simple mais solide. Attention à ne pas le casser !"]
}


func _ready(): 
	visible = false
	add_item("baton")

func _process(_delta):
	if Input.is_action_just_pressed("open_inventory") and $".."._location != "Overworld" and $"..".in_dialog() == false and $"../../Level".visible == true and $"..".visible == true :
		if visible == true :
			close_inventory()
		else :
			open_inventory()
	if Input.is_action_just_pressed("left_click") and visible == true:
		var item_selected = int(item_list.get_item_at_position(get_global_mouse_position()))
		print(item_selected)
		$item_info/descriptton.text = item_inventory[item_selected][4]
		$item_info/stats.text = "
		ATK +"+ str(item_inventory[item_selected][1])+"
		DEF +"+ str(item_inventory[item_selected][2])+"
		HP +"+ str(item_inventory[item_selected][3])
		$item_info/item_icon.texture = load(item_inventory[item_selected][0])
		
		
		
func open_inventory() :
	SignalBus.emit_signal("update_FriskUI", $"../..".allies["Frisk"][0], $"../..".allies["Frisk"][1], $"../..".allies["Frisk"][2])
	get_tree().paused = true
	visible = true
	
func close_inventory():
	get_tree().paused = false
	visible = false

func add_item(id) :
	item_inventory.push_back(item_data[id])
	var icon = load(item_data[id][0])
	item_list.add_icon_item(icon)
	
func lose_item(id):
	item_inventory[id].erase(id)
	item_list.remove_item(id)
