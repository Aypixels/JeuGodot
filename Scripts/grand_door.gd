extends Area2D
@onready var the_grand_door = $"../The_Grand_Door"
var player_in

func _on_body_entered(body):
	if body.has_method("player") :
		player_in = true
		SignalBus.emit_signal("show_spacebar")
func _on_body_exited(body):
	if body.has_method("player") :
		player_in = false
		SignalBus.emit_signal("hide_spacebar")
		the_grand_door.play("default")


func _process(_delta) :
	if Input.is_action_just_pressed("interact") and player_in :
		player_in = false
		SignalBus.emit_signal("hide_spacebar")
		the_grand_door.play("opened")


