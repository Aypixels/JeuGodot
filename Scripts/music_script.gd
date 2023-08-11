extends Node

@onready var music = $scarlet_forest

func _ready():
	SignalBus.fight.connect(cut_sound)
	SignalBus.victory.connect(recover_sound_combat)
	music.stream_paused= false
	SignalBus.memory.connect(switch_music)

func cut_sound(_a, _b) :
	music.stream_paused = true
	
func recover_sound_combat():
	await get_tree().create_timer(2).timeout
	music.stream_paused = false
	
func recover_sound_ambient():
	music.volume_db = -30
	music.stream_paused = false
	while music.volume_db < 0 :
		music.volume_db += 1
		await get_tree().create_timer(0.04).timeout

func _process(_delta):
	if music.playing == false and music.stream_paused == false :
		music.play()

func switch_music() :
	while music.volume_db > -80 :
		music.volume_db -= 1
		await get_tree().create_timer(0.04).timeout
	music.stream_paused = true
	music = $castle_town
