extends Node2D

var card_in_slot = false
var current_card = null
var current_card_image_path = ""
var deck_reference
var rng = RandomNumberGenerator.new()

@onready var healthbar = $Healthbar
@onready var card_manager = $"../cardManager"
@onready var texture_progress_bar = $"../CanvasLayer/TextureProgressBar"
@onready var countdownLabel = $"../Countdown/countdownLabel"
@onready var end_turn = $"../endTurn"
@onready var timer = $"../Countdown/Timer"
@onready var ambient_song = $"../AmbientSong"


func _ready() -> void:
	healthbar.init_health(100)
	deck_reference = $"../Deck"

func place_card(card):
	current_card = card
	card_in_slot = true
	var card_texture = card.get_node("cardImg").texture
	if card_texture:
		current_card_image_path = card_texture.resource_path

func take_damage():
	if card_in_slot:
		if current_card_image_path == "res://assets/card_images/PharaoStrike.png":
			healthbar.health -= 15
			texture_progress_bar.reduce_time(6)
		elif current_card_image_path == "res://assets/card_images/PraySun.png":
			healthbar.health -= 0
			texture_progress_bar.add_time(5)
		elif current_card_image_path == "res://assets/card_images/SolarBlade.png":
			healthbar.health -= 9
			texture_progress_bar.reduce_time(4)
		delete_card()

func delete_card():
	if current_card:
		current_card.queue_free()
		current_card = null
	card_in_slot = false

func _on_end_turn_pressed() -> void:
	end_turn.process_mode = Node.PROCESS_MODE_ALWAYS
	texture_progress_bar.process_mode = Node.PROCESS_MODE_ALWAYS
	timer.process_mode = Node.PROCESS_MODE_ALWAYS
	ambient_song.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	await get_tree().create_timer(0.67).timeout
	var chronarc_attack = rng.randf_range(4, 13)
	texture_progress_bar.reduce_time(chronarc_attack)
	await get_tree().create_timer(0.67).timeout
	get_tree().paused = false
