extends Node

signal dialog_display(name,text_key)
signal memory
signal end_road()
signal go_to_castle()

signal fight(combat_index, enemies)
signal place_combat(combat_index, enemies)
signal battle_dialog_display(text_key)
signal update_FriskUI(Maxhp, LV, hp)
signal new_turn()
signal enemy_attack(ATK)
signal switch_turn(who)
signal defeated(ID)
signal victory()


func _ready():
	RenderingServer.set_default_clear_color("black")
