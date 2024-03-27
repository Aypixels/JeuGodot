extends Node2D

@onready var turn = $Turn

func _ready():
	SignalBus.place_combat.connect(start_fight)
	SignalBus.switch_turn.connect(on_switch_turn)
	
func start_fight(combat_index, _enemies, _allies) :
	$Background.play(combat_index)
	get_node(combat_index).play()
	
func on_switch_turn(who):
	turn.play(who+"_turn")
			
