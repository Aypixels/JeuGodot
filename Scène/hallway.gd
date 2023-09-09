extends Node2D

@onready var game = $"../.."


func _ready():
	if game.period == "night":
		set_modulate(Color(0.1,0.1,0.4,1))
		$"../../Player".set_modulate(Color(0.1,0.1,0.3,1))
		

