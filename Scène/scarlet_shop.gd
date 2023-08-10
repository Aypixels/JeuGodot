extends Container

@onready var player = $"../../Player"
@onready var text = $dialog_box/text

var text_index = 0
var texts = ["* Hee hee...
* Bienvenue, voyageur",
"* C'est dangereux plus loin...
Tu le sais déjà, non ?",
"* Tu attends quelque chose de moi ...?",
"* Reviens plus tard"]


func _ready():
	show_shop()
	show_text(0)
	$Seam.play("default")

func show_shop() :
	player.visible = false
	player.stop = true
	
	visible = true
	position = player.get_cam_pos()
	
func hide_shop():
	queue_free()
	player.visible = true
	player.stop = false
	
func show_text(id):
	text.text = texts[id]
	text.visible_characters = 0
	while text.visible_characters < len(text.text) :
		text.visible_characters+=1
		await get_tree().create_timer(0.04).timeout
	
	
	
func _on_exit_pressed():
	hide_shop()

func _on_talk_pressed():
	if text_index < 3 :
		text_index += 1
	if text_index == 1 :
		await get_tree().create_timer(0.4).timeout
		$Seam.play("smiling")
	else :
		$Seam.play("default")
	show_text(text_index)
