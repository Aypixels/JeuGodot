extends AudioStreamPlayer


func _ready():
	SignalBus.fight.connect(cut_sound)
	stream_paused= false

func cut_sound(_a, _b) :
	stream_paused = true

func _process(_delta):
	if playing == false and stream_paused == false :
		play()
