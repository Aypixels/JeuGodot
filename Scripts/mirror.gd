extends Area2D
var player_in 
@onready var mirror = $"../AnimatedSprite2D"
@onready var player = $"../../../../Player"
@onready var game = $"../../../.."
@onready var fondu = $"../mirrorfondu"


func _on_body_entered(body):
	if body.has_method("player"):
		player_in = true
		SignalBus.emit_signal("show_spacebar")
func _on_body_exited(body):
	if body.has_method("player") :
		player_in = false
		SignalBus.emit_signal("hide_spacebar")


func _process(_delta) :
	if Input.is_action_just_pressed("interact") and player_in :
		if game.omori_opened:
			player_in = false
			SignalBus.emit_signal("hide_spacebar")
			player.stop = true
			mirror.show()
			fondu.play("mirrorfonu")
			mirror.position = player.position
			await fondu.animation_finished
			mirror.play("default")
			await get_tree().create_timer(1).timeout
			
			player.stop = false
			SignalBus.emit_signal("dialog_display", "mirror")
			await SignalBus.dialog_finished
			await get_tree().create_timer(3).timeout
			SignalBus.emit_signal("go_to", "omori_start", false, "wrap_zone")
			
		else:
			SignalBus.emit_signal("dialog_display", "non_accessible")
		
		

