extends Area2D
@onready var the_grand_door = $"../The_Grand_Door"


func _on_body_entered(body):
	if body.has_method("player") :
		the_grand_door.play("opened")
