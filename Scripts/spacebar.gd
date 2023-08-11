extends Area2D

var show_spacebar = false

func _on_body_entered(body):
	if body.has_method("show_spacebar") :
		show_spacebar = true
		print("good")


func _on_body_exited(body):
	if body.has_method("show_spacebar") :
		show_spacebar = false

func _process(_delta):
	if show_spacebar :
		$"../Spacebar".visible = true
