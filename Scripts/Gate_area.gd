extends Area2D
@onready var gate = get_parent().get_node("AnimatedSprite2D")
@onready var gate_collision = get_parent().get_node("CollisionShape2D")
var is_body_inside = false


func _on_body_entered(body):
	if body.has_method("player") :
		is_body_inside = true
		gate.play("gate")

func _on_body_exited(body):
	if body.has_method("player") :
		is_body_inside = false
		gate.play_backwards("gate")
	

func _process(_delta):
	if is_body_inside:
		if gate.frame == 4:
			gate.pause()
			gate_collision.set_deferred("disabled", true)
	else:
		if gate.frame == 0:
			gate.pause()
			gate_collision.set_deferred("disabled", false)
