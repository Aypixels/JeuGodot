extends Node

signal dialog_display(name,text_key)
signal end_road()
signal fight(combat_index, enemies)
signal place_combat(combat_index, enemies)
signal battle_dialog_display(text_key)
signal set_up_FriskUI(Maxhp, LV, hp)

func _ready():
	RenderingServer.set_default_clear_color("black")
