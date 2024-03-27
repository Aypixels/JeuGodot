extends Area2D
var player_in = false

func _on_body_entered(body):
	if body.has_method("player") and not $"../../..".inventory.has_item("res://assets/Items/green_egg.png") :
		player_in = true
		SignalBus.emit_signal("show_spacebar")
func _on_body_exited(body):
	if body.has_method("player") and not $"../../..".inventory.has_item("res://assets/Items/green_egg.png"):
		player_in = false
		SignalBus.emit_signal("hide_spacebar")


func _process(_delta):
	if Input.is_action_just_pressed("interact") and player_in :
		player_in = false
		SignalBus.emit_signal("hide_spacebar")
		SignalBus.emit_signal("dialog_display", "man_tree")
		SignalBus.emit_signal("add_item_inventory", "oeuf vert")

