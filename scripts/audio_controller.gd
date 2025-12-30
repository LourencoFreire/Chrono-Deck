extends Node2D

@export var mute: bool = false

func _ready():
	if not mute:
		play_egyptAmbient()

func play_egyptAmbient():
	if not mute:
		$egyptAmbient.play()
