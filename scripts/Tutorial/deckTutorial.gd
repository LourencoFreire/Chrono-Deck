extends Node2D

const CARD_SCENE = preload("res://scenes/card.tscn")
const CARD_IMAGES_PATH = "res://assets/card_images/"

@onready var card_manager = $"../cardManager"
@onready var hand = $"../Hand"

var image_path = ""
var card_weights = {
	"SolarBlade": 30,
	"SandShield": 26,
	"PharaoStrike": 26,
	"PraySun": 23,
	"SolarStasis": 20
}

func _ready() -> void:
	pass

func draw_card():
	if hand.is_hand_full():
		return null
	var card_name = get_weighted_random_card()
	var new_card = CARD_SCENE.instantiate()
	new_card.name = card_name
	image_path = CARD_IMAGES_PATH + card_name + ".png"
	if ResourceLoader.exists(image_path):
		new_card.get_node("cardImg").texture = load(image_path)
	card_manager.add_child(new_card)
	card_manager.connect_card_signals(new_card)
	hand.add_card_to_hand(new_card)
	return new_card

func get_weighted_random_card() -> String:
	var total_weight = 0
	for weight in card_weights.values():
		total_weight += weight
	var random_value = randf() * total_weight
	var cumulative_weight = 0
	for card_name in card_weights.keys():
		cumulative_weight += card_weights[card_name]
		if random_value <= cumulative_weight:
			return card_name
	return card_weights.keys()[0]
