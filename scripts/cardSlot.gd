extends Node2D

var card_in_slot = false
var current_card = null

@onready var healthbar = $Healthbar
@onready var card_manager = $"../cardManager"

func _ready() -> void:
	healthbar.init_health(75)

func take_damage():
	if card_in_slot:
		healthbar.health -= 15
		delete_card()

func delete_card():
	if current_card:
		current_card.queue_free()
		current_card = null
	card_in_slot = false
