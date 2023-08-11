extends Sprite2D

var battle_text = {
	"something_run" : ["* M'enfuir ne me semble pas être une option"],
	"clear" : [""],
	"win_something": ["* Something à été vaincu"],
	"choose_target" : ["* Qui vais-je attaquer ?"]
}
var selected_text = []
var in_progress= false
var phrase_end = false

@onready var text_label = $RichTextLabel
@onready var indicator = $DialogboxIndicator


func _ready():
	SignalBus.battle_dialog_display.connect(on_battle_dialog_display)
	indicator.visible = false
	
func show_text():
	text_label.visible_characters = 0
	phrase_end = false
	text_label.text = selected_text.pop_front()
	
	while text_label.visible_characters < len(text_label.text) :
		text_label.visible_characters+=1
		await get_tree().create_timer(0.02).timeout
	phrase_end = true
	
		
func finish() :
	text_label.text = ""
	in_progress = false
	phrase_end = false
		
func on_battle_dialog_display(text_key) :
	finish()
	in_progress = true
	selected_text = battle_text[text_key].duplicate()
	show_text()
		

func _process(_delta):
	if phrase_end :
		indicator.visible = true
	else :
		indicator.visible = false
