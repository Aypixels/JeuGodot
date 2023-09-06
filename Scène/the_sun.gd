extends Area2D
var player_in = false
var T = 1
@onready var enter_oneshot = $"../enter_oneshot"
@onready var player = $"../../../../Player"

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
		$"../PointLight2D".enabled = false
		SignalBus.emit_signal("hide_spacebar")
		enter_oneshot.position = player.position
		player.stop = true
		enter_oneshot.play("default")
		enter_oneshot.show()
		enter_oneshot.speed_scale = 1
	
	if enter_oneshot.frame == 4 :
		enter_oneshot.speed_scale = 5
	if enter_oneshot.frame == 9 :
		enter_oneshot.stop()
		enter_oneshot.hide()
		player.stop = false
		

