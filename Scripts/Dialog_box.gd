extends Container

var scene_text = {
	"player_cat" : [["Moi","Chat noir"],["Où suis-je ?","Meow...?"]]
}
var selected_text = []
var selected_name = []
var in_progress= false

@onready var background = $Dialogbox2
@onready var text_label = $Dialogbox2/Text
@onready var text_name = $Dialogbox2/Name
@onready var indicator = $Dialogbox2/DialogboxIndicator

func _ready():
	background.visible = false
	SignalBus.dialog_display.connect(on_dialog_display)
	
func show_text():
	text_name.text = selected_name.pop_front()
	text_label.text = selected_text.pop_front()
	
func next_phrase():
	if selected_text.size() > 0 :
		show_text()
	else : 
		finish()
		
func finish() :
	text_label.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false
		
func on_dialog_display(text_key) :
	if in_progress :
		next_phrase()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_name = scene_text[text_key][0].duplicate()
		selected_text = scene_text[text_key][1].duplicate()
		assert(len(selected_name) == len(selected_text), "Erreur dans le nombre de dialogue")
		show_text()
		

