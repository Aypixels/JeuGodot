extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.open_UI.connect(show_UI)

func show_UI(id) :
	add_child(load("res://Scène/"+id+".tscn").instantiate())

