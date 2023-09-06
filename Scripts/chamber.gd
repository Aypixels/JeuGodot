extends Node2D

# Amplitude du tremblement
var shake_amplitude = 10.0

# Durée du tremblement en secondes
var shake_duration = 0.5

# Position d'origine de l'écran
var original_position = Vector2.ZERO

func _ready():
	# Stocker la position d'origine
	original_position = position

func _process(delta):
	if shake_duration > 0:
		# Générer un décalage aléatoire pour le tremblement
		var offset = Vector2(randf_range(-shake_amplitude, shake_amplitude), randf_range(-shake_amplitude, shake_amplitude))
		# Appliquer le décalage à la position
		position = original_position + offset
		
		# Réduire la durée du tremblement           
		shake_duration -= delta
	else:
		# Réinitialiser la position une fois le tremblement terminé
		position = original_position
