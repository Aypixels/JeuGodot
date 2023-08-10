extends Area2D

var player_in = false


func _on_body_entered(body):
	if body.has_method("player") :
		player_in = true

func _on_body_exited(body):
	if body.has_method("player") :
		player_in = false


func _process(_delta):
	if Input.is_action_just_pressed("interact") and player_in:
		player_in = false
		SignalBus.emit_signal("open_UI", "scarlet_shop")
		SignalBus.emit_signal("seam")

