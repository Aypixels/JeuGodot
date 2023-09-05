extends Area2D
var player_in = false
@onready var window = $"../Window"


func _on_body_entered(body):
	if body.has_method("player") :
		player_in = true
		SignalBus.emit_signal("show_spacebar")
func _on_body_exited(body):
	if body.has_method("player") :
		player_in = false
		SignalBus.emit_signal("hide_spacebar")


func _process(_delta):
	if Input.is_action_just_pressed("interact") and player_in:
		player_in = false
		SignalBus.emit_signal("hide_spacebar")
		window.visible = true
		await get_tree().create_timer(1).timeout
		window.visible = false

