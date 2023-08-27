extends CanvasLayer

func _ready():
	SignalBus.open_UI.connect(show_UI)

func show_UI(id) :
	add_child(load("res://Scène/"+id+".tscn").instantiate())
	$"../Player".hide_spacebar()

