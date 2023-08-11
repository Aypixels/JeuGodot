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

#Général
signal location(location)
signal go_to(direction)
signal dialog_display(name,text_key)
signal open_UI(id)
signal show_spacebar()
signal hide_spacebar()

func _ready():
	RenderingServer.set_default_clear_color("black")
