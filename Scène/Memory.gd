extends Area2D
var memory = false

func _on_body_entered(body):
	if body.has_method("player"):
		memory = true

func _process(_delta):
	if memory :
		SignalBus.emit_signal("memory")
		await get_tree().create_timer(1.5).timeout
		SignalBus.emit_signal("dialog_display", "memory")
		await get_tree().create_timer(3).timeout
		SignalBus.emit_signal("dialog_display", "memory")
		$CollisionShape2D.set_deferred("disabled" , true)
		memory = false
