extends Sprite2D

@export var dialog_Path = ""

var dialog

var phraseNum = 0
var finished = false



func _ready():
	dialog = dialog_Path.scripts
	assert(dialog, "Dialog not found")
	nextPhrase()
	
func _process(delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished :
			nextPhrase() 
		else:
			$Text.visible_characters = len($Text.text)

	
func nextPhrase() :
	if phraseNum >= len(dialog):
		queue_free()
		return 
		
	finished = false
	
	$Name.bbcode_text = dialog.scripts[]
	$Text.bbcode_text = dialog.scripts[]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text) :
		$Text.visible_characters+= 1
		
		await get_tree().create_timer(0.5).timeout


		
	finished = true
	phraseNum += 1
	return
