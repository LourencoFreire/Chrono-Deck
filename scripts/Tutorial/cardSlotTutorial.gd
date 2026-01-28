extends Node2D

var card_in_slot = false
var current_card = null
var current_card_image_path = ""
var deck_reference
var rng = RandomNumberGenerator.new()
var chronarc_attack
var card_effect = ""

@onready var healthbar = $Healthbar
@onready var card_manager = $"../cardManager"
@onready var texture_progress_bar = $"../CanvasLayer/TextureProgressBar"
@onready var countdownLabel = $"../Countdown/countdownLabel"
@onready var end_turn: Button = $"../endTurn"
@onready var timer: Timer = $"../Countdown/Timer"
@onready var ambient_song: AudioStreamPlayer = $"../AmbientSong"
@onready var options: Panel = $"../Options"
@onready var hand = $"../Hand"

func _ready() -> void:
	healthbar.init_health(75)
	deck_reference = $"../Deck"

func place_card(cardTutorial):
	current_card = cardTutorial
	card_in_slot = true
	var card_texture = cardTutorial.get_node("cardImgTutorial").texture
	if card_texture:
		current_card_image_path = card_texture.resource_path

func take_damage():
	if card_in_slot:
		deck_reference.process_mode = Node.PROCESS_MODE_DISABLED
		healthbar.health -= 15
		texture_progress_bar.reduce_time(6)
		delete_card()

func delete_card():
	if current_card:
		current_card.queue_free()
		current_card = null
	card_in_slot = false


func _on_end_turn_pressed() -> void:
	deck_reference.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(0.67, false).timeout
	chronarc_attack = rng.randf_range(4, 13)
	if card_effect == "SandShield":
		chronarc_attack *= 0.5
		card_effect = ""
	if card_effect == "SolarStasis":
		chronarc_attack = 0
		card_effect = ""
	texture_progress_bar.reduce_time(chronarc_attack)
	await get_tree().create_timer(0.67, false).timeout
	get_tree().paused = false
