extends Area2D

func _on_body_entered(body):
	if body.has_method("player") :
		SignalBus.emit_signal("go_to", "chamber")
		await get_tree().create_timer(0.8).timeout
		SignalBus.emit_signal("location", "Overworld")
