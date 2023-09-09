extends Area2D

func _on_body_entered(body):
	if body.has_method("player"):
		SignalBus.emit_signal("go_to", "deltarune_start", true, "wrap_zone")


