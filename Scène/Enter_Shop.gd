extends Area2D




func _on_body_entered(body):
	if body.has_method("player") and Input.is_action_just_pressed("interact"):
		SignalBus.emit_signal("open_UI")
