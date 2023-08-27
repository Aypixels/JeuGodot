extends ItemList


func _on_item_selected(_index):
	print("ceci est un test")


func _on_item_clicked(_index, _at_position, _mouse_button_index):
	print("double test")
