extends Node2D

# Amplitude du tremblement
var shake_amplitude = 10.0

# Durée du tremblement en secondes
var shake_duration = 0.5

# Position d'origine de l'écran
var original_position = Vector2.ZERO

func _ready():
	if $"../..".period == "night":
		$"../../Player".set_modulate(Color(0.4,0.4,0.7,1))
	else:
		$"../../Player".set_modulate(Color(1,1,1,1))
	original_position = position

func _process(delta):
	if shake_duration > 0 and $"../..".exit_opened :
		# Générer un décalage aléatoire pour le tremblement
		var offset = Vector2(randf_range(-shake_amplitude, shake_amplitude), randf_range(-shake_amplitude, shake_amplitude))
		# Appliquer le décalage à la position
		position = original_position + offset
		
		# Réduire la durée du tremblement           
		shake_duration -= delta
	elif $"../..".exit_opened :
		# Réinitialiser la position une fois le tremblement terminé
		position = original_position
		$"../..".exit_opened = false
