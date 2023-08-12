extends Container

@onready var player = $"../../Player"
@onready var text = $dialog_box/text

var text_index = 0
var texts = ["* Hee hee...
* Bienvenue, voyageur",
"* J'm'appelle Seam 
* Ça se prononce «Shawm»",
"* C'est dangereux plus loin...
Tu le sais déjà, non ?",
"* Tu attends quelque chose de moi ...?",
"* Reviens plus tard"]

func _ready():
	show_shop()
	show_text(0)
	$Seam.play("default")
	$"../../Level/Tutoriel/Musics".cut_sound(0, 0)
	$seam_shop.volume_db = -30
	$seam_shop.play()
	while $seam_shop.volume_db < 0 :
		$seam_shop.volume_db += 1
		await get_tree().create_timer(0.04).timeout


	
func show_shop() :
	player.visible = false
	player.camera_stop()
	player.stop = true
	
	visible = true
	position = player.get_cam_pos()
	
func hide_shop():
	player.camera_recover()
	queue_free()
	player.visible = true
	player.stop = false
	$"../../Level/Tutoriel/Musics".recover_sound_ambient()

func show_text(id):
	text.text = texts[id]
	text.visible_characters = 0
	while text.visible_characters < len(text.text) :
		text.visible_characters+=1
		await get_tree().create_timer(0.04).timeout
	
	
	
func _on_exit_pressed():
	hide_shop()

func _on_talk_pressed():
	if text_index < len(texts) - 1 :
		text_index += 1
	if text_index == 1 :
		await get_tree().create_timer(0.4).timeout
		$Seam.play("smiling")
	else :
		$Seam.play("default")
	show_text(text_index)
