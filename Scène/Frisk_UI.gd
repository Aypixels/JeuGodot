extends AnimatedSprite2D

@onready var lvl = $lvl
@onready var hp = $hp
@onready var health_bar = $ProgressBar

var health : int

func _ready():
	SignalBus.set_up_FriskUI.connect(set_up)
	
func set_up(Maxhp, current_hp, lv):
	lvl.text = "LV "+lv 
	hp.text = current_hp+"/"+Maxhp
	health = int(current_hp)
	health_bar.max_value=int(Maxhp)

func _process(_delta):
	health_bar.value=health
