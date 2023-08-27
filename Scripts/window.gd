extends Area2D

var player_in = false

func _on_body_entered(body):
	if body.has_method("player"):
		SignalBus.emit_signal("show_spacebar")
		player_in = true


func _on_body_exited(body):
	if body.has_method("player"):
		SignalBus.emit_signal("hide_spacebar")
		player_in = false

func _process(_delta):
	if Input.is_action_just_pressed("interact") and player_in:
		SignalBus.emit_signal("dialog_display", "window")
