extends Area2D

@export var dialog_key = ""
var area_active = false

func _input(event):
	if area_active and event.is_action_pressed("interact"):
		SignalBus.emit_signal("dialog_display", dialog_key)


func _on_area_entered(_area):
	area_active = true
	SignalBus.emit_signal('show_spacebar')

func _on_area_exited(_area):
	area_active = false
	SignalBus.emit_signal('hide_spacebar')	

