extends Area2D

func _on_body_entered(body):
	if body.has_method("player"):
		SignalBus.emit_signal("show_spacebar")


func _on_body_exited(body):
	if body.has_method("player"):
		SignalBus.emit_signal("hide_spacebar")

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		SignalBus.emit_signal("dialog_display", "window")
