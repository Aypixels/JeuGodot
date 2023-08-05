extends Node2D

func _ready():
	SignalBus.fight.connect(start_fight)
	
func start_fight(combat_index, _enemies) :
	print("good")
	$Background.play(combat_index)

