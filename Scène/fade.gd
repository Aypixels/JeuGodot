extends Polygon2D

var T = 0.00

func _ready():
	go_bright()

func go_dark():
	while float(T) > 0.00 :
		T-=0.05
		set_color(Color(1,1,1,T))
		await get_tree().create_timer(0.1).timeout
	go_bright()
	
func go_bright() :
	while float(T) < 1.00 :
		T+=0.05
		set_color(Color(1,1,1,T)) 
		await get_tree().create_timer(0.1).timeout
	go_dark()
