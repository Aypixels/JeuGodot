extends CharacterBody2D

var speed = 20
var moving = false
var rng = RandomNumberGenerator.new()

func _process(_delta):
	if not moving :
		var move = rng.randi_range(0,100)
		if move == 0:
			moving = true
			var distance = rng.randi_range(-1,1)
			if distance == -1 :
				$AnimatedSprite2D.play("left")
			elif distance == 1 :
				$AnimatedSprite2D.play("right")
			else :
				$AnimatedSprite2D.play("sit")
			for i in range(40) :
				velocity.x = speed*distance
				move_and_slide()
				await get_tree().create_timer(0.04).timeout
			moving = false
		else:
			$AnimatedSprite2D.play("sit")
