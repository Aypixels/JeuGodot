extends Node

@onready var music = $scarlet_forest

func _ready():
	SignalBus.fight.connect(cut_sound)
	SignalBus.victory.connect(recover_sound)
	music.stream_paused= false
	SignalBus.memory.connect(switch_music)

func cut_sound(_a, _b) :
	music.stream_paused = true
func recover_sound():
	music.stream_paused = false

func _process(_delta):
	if music.playing == false and music.stream_paused == false :
		music.play()

func switch_music() :
	while music.volume_db > -100 :
		music.volume_db -= 1
		await get_tree().create_timer(0.02).timeout
	music.stream_paused = true
	music = $castle_town
