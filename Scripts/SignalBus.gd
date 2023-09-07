extends Node

#Tutoriel
signal memory
signal end_road()

#Combat
signal fight(combat_index, enemies)
signal place_combat(combat_index, enemies)
signal battle_dialog_display(text_key)
signal update_FriskUI(Maxhp, LV, hp)
signal new_turn()
signal enemy_attack(ATK)
signal switch_turn(who)
signal defeated(id)
signal victory()
signal lose()

#Général
signal location(location)
signal go_to(direction, transition)
signal dialog_display(name,text_key)
signal open_UI(id)
signal show_spacebar()
signal hide_spacebar()
signal add_item_inventory(id)
signal dialog_finished

func _ready():
	RenderingServer.set_default_clear_color("black")



