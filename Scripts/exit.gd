extends Area2D

func _on_body_entered(body):
	if body.has_method("player")  :
		SignalBus.emit_signal("go_to", "chamber", true, "wrap_zone")
		await get_tree().create_timer(0.9).timeout
		SignalBus.emit_signal("location", "Overworld")
		
	
func _ready():
	if not $"../../../..".exit_opened :
		$"../exit_visual".hide()
		$CollisionShape2D.set_deferred("disabled", true)
	else :
		$"../exit_visual".show()
		$CollisionShape2D.set_deferred("disabled", false)
