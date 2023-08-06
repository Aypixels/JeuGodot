extends Node2D

func _ready():
	SignalBus.place_combat.connect(start_fight)
	
func start_fight(combat_index, _enemies, _allies) :
	$Background.play(combat_index)
	get_node(combat_index).play()
	

