extends CharacterBody2D

var launch = false
var combat_path = preload("res://Scène/Combat_scene.tscn")

func _ready():
	$AnimatedSprite2D.visible=false
	SignalBus.end_road.connect(on_end_road)
	
func on_end_road() :
	$AnimatedSprite2D.visible = true
	launch = true
	$AnimatedSprite2D.play("appear")
	
func _process(_delta) :
	if launch == true:
		if $AnimatedSprite2D.frame == 10 :
			$AnimatedSprite2D.play("walk")
			$"../Engage".play()
			$"..".visible = false
			await get_tree().create_timer(0.1).timeout
			$"..".visible = true
			await get_tree().create_timer(0.1).timeout
			$"..".visible = false
			await get_tree().create_timer(0.1).timeout
			$"..".visible = true
			await get_tree().create_timer(0.1).timeout
			$"..".visible = false
			await get_tree().create_timer(0.6).timeout
			SignalBus.emit_signal("fight", "something", ["something"])
			get_tree().change_scene_to_packed(combat_path)
			print("signale bien envoyé")
			launch = false
