extends AnimatedSprite2D

@onready var blanket = $"../Blanket"

func _ready():
	if animation.get_basename() == "night":
		blanket.visible = true
	else:
		blanket.visible = false
