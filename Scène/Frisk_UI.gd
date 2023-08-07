extends AnimatedSprite2D

@onready var lvl = $lvl
@onready var hp = $hp
@onready var health_bar = $ProgressBar

var health : int

func _ready():
	SignalBus.update_FriskUI.connect(update)
	
func update(Maxhp, current_hp, lv):
	lvl.text = "LV "+str(lv)
	hp.text = str(current_hp)+"/"+str(Maxhp)
	health = current_hp
	health_bar.max_value=Maxhp

func _process(_delta):
	health_bar.value=health
