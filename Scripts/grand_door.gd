extends Area2D
@onready var the_grand_door = $"../The_Grand_Door"
var player_in

func _on_body_entered(body):
	if body.has_method("player") :
		player_in = true

func _on_body_exited(body):
	if body.has_method("player") :
		player_in = false


func _process(_delta) :
	if Input.is_action_just_pressed("interact") and player_in :
		player_in = false
		the_grand_door.play("opened")


