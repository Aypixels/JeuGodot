extends Area2D

@onready var castle = $"../.."
@onready var the_grand_door = $"../The_Grand_Door"
var player_in

func _on_body_entered(body):
	if body.has_method("player") and the_grand_door.animation != "opened" :
		player_in = true
		SignalBus.emit_signal("show_spacebar")
func _on_body_exited(body):
	if body.has_method("player") :
		player_in = false
		SignalBus.emit_signal("hide_spacebar")


func _process(delta) :
	if Input.is_action_just_pressed("interact") and player_in :
		if $"../../../..".deltarune_opened:
			player_in = false
			SignalBus.emit_signal("hide_spacebar")
			the_grand_door.play("opened")
			$"../CollisionShape2D".set_deferred("disabled", true)
			$"../CollisionPolygon2D".set_deferred("disabled", false)
		else:
			SignalBus.emit_signal("dialog_display", "non_accessible")
	if shake_duration > 0 and the_grand_door.animation == "opened":
		var offset = Vector2(randf_range(-shake_amplitude, shake_amplitude), randf_range(-shake_amplitude, shake_amplitude))
		castle.position = original_position + offset
		
		shake_duration -= delta
	else:
		castle.position = original_position


var shake_amplitude = 9.0
var shake_duration = 0.5
var original_position = Vector2.ZERO

func _ready():
	original_position = castle.position




