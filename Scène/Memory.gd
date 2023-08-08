extends Area2D
var memory = false

func _on_body_entered(body):
	if body.has_method("player"):
		SignalBus.emit_signal("memory")



