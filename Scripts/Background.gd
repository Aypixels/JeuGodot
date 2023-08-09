extends AnimatedSprite2D

func _ready():
	if animation.get_basename() == "night":
		$Blanket.visibility_layer = true
	else:
		$Blanket.visibility_layer = false
