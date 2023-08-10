extends Container

var scene_text = {
	"player_cat" : [["Toi","Chat noir"],["Où suis-je ?","Meow...?"]],
	'memory': [["Toi", "Toi"], ["Mmh...", "Cet endroit me semble familier..."]]
}
var selected_text = []
var selected_name = []
var in_progress= false
var phrase_end = false

@onready var background = $Dialogbox2
@onready var text_label = $Dialogbox2/Text
@onready var text_name = $Dialogbox2/Name
@onready var indicator = $Dialogbox2/DialogboxIndicator

func _ready():
	background.visible = false
	SignalBus.dialog_display.connect(on_dialog_display)
	
func show_text():
	text_label.visible_characters = 0
	phrase_end = false
	text_name.text = selected_name.pop_front()
	text_label.text = selected_text.pop_front()
	
	while text_label.visible_characters < len(text_label.text) :
		text_label.visible_characters+=1
		await get_tree().create_timer(0.04).timeout
	phrase_end = true
	
func next_phrase():
	if selected_text.size() > 0 :
		show_text()
	else : 
		finish()
		
func finish() :
	text_label.text = ""
	background.visible = false
	in_progress = false
	phrase_end = false
	get_tree().paused = false
		
func on_dialog_display(text_key) :
	$"..".go_idle()
	get_tree().paused = true
	background.visible = true
	selected_name = scene_text[text_key][0].duplicate()
	selected_text = scene_text[text_key][1].duplicate()
	assert(len(selected_name) == len(selected_text), "Erreur dans le nombre de dialogue")
	show_text()
	await get_tree().create_timer(0.2).timeout
	in_progress = true

func _process(_delta):
	if in_progress and phrase_end and Input.is_action_just_pressed("interact") :
		next_phrase()
	elif in_progress and Input.is_action_just_pressed("interact") :
		text_label.visible_characters = len(text_label.text)
		phrase_end = true
	if phrase_end :
		indicator.visible = true
	else :
		indicator.visible = false
