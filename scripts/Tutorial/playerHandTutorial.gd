extends Node2D

const CARD_WIDTH = 200
const HAND_Y_POSITION = 890
const MAX_HAND_SIZE = 3

var player_hand = []
var center_screen_x

func _ready() -> void:
	center_screen_x = get_viewport().size.x / 2

func is_hand_full() -> bool:
	return player_hand.size() >= MAX_HAND_SIZE

func add_card_to_hand(card):
	if not card:
		return
	if card.has_node("Area2D/CollisionShape2D"):
		card.get_node("Area2D/CollisionShape2D").disabled = false
	if card in player_hand:
		animate_card_to_position(card, card.starting_position)
		return
	if is_hand_full():
		return
	player_hand.insert(0, card)
	update_hand_positions()

func update_hand_positions():
	for i in range(player_hand.size()):
		var new_position = Vector2(calculate_card_position(i), HAND_Y_POSITION)
		var card = player_hand[i]
		card.starting_position = new_position
		animate_card_to_position(card, new_position)

func calculate_card_position(index):
	var total_width = (player_hand.size() -1) * CARD_WIDTH
	var x_offset = center_screen_x + index * CARD_WIDTH - total_width / 2
	return x_offset

func animate_card_to_position(card, new_position):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_position, 0.1)

func remove_card_from_hand(card):
	var index = player_hand.find(card)
	if index != -1:
		player_hand.remove_at(index)
		update_hand_positions()
