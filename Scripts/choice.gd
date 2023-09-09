extends CanvasLayer

@onready var current = $Attack
@onready var bruh = $"../CombatDialogBox/RichTextLabel"

func _ready():
	current.grab_focus()
	$"../select_special".hide()
	
func _process(_delta):
	if visible:
		if Input.is_action_just_pressed("Right") and current.get_node(current.focus_neighbor_right) != bruh and current.get_node(current.focus_neighbor_right).visible == true:
			print(current.get_node(current.focus_neighbor_right).text)
			current = current.get_node(current.focus_neighbor_right)
			current.grab_focus()
		if Input.is_action_just_pressed("Left") and current.get_node(current.focus_neighbor_left) != bruh and current.get_node(current.focus_neighbor_left).text != "":
			current = current.get_node(current.focus_neighbor_left)
			current.grab_focus()
		if Input.is_action_just_pressed("up") and current.get_node(current.focus_neighbor_top) != bruh and current.get_node(current.focus_neighbor_top).text != "":
			current = current.get_node(current.focus_neighbor_top)
			current.grab_focus()
		if Input.is_action_just_pressed("down") and current.get_node(current.focus_neighbor_bottom) != bruh and current.get_node(current.focus_neighbor_bottom).text != "":
			current = current.get_node(current.focus_neighbor_bottom)
			current.grab_focus()
			
func _on_ennemy_group_next_player():
	$Attack.grab_focus()
	current = $Attack
