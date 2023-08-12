extends Control


func _process(_delta):
	if Input.is_action_just_pressed("open_inventory") and $".."._location != "Overworld" and $"..".in_dialog() == false and $"../../Level".visible == true and $"..".visible == true :
		if visible == true :
			close_inventory()
		else :
			open_inventory()
		
func open_inventory() :
	SignalBus.emit_signal("update_FriskUI", $"../..".allies["Frisk"][0], $"../..".allies["Frisk"][1], $"../..".allies["Frisk"][2])
	get_tree().paused = true
	visible = true
	
func close_inventory():
	get_tree().paused = false
	visible = false
