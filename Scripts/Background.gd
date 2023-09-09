extends AnimatedSprite2D

@onready var blanket = $"../Blanket"
@onready var game = $"../../.."
func _ready():
	if  game.period == "night":
		blanket.visible = true
	else:
		blanket.visible = false
