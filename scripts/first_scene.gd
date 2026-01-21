extends Control

@onready var text_label = $text
@onready var voice = $Voice

var current_segment = 0
var current_char = 0
var typing_speed = 0.067
var typing_timer: Timer
var pause_timer: Timer
var text_segments = [
	{"text": "I used to think time was something you lost slowly", "pause_after": 0.5},
	{"text": "Days passing.. Moments slipping away", "pause_after": 0.1},
	{"text": "more text that i still have to think", "pause_after": 0.1}
]

func _ready() -> void:
	call_deferred("_setup_timers")

func _setup_timers():
	typing_timer = Timer.new()
	add_child(typing_timer)
	typing_timer.wait_time = typing_speed
	typing_timer.one_shot = false
	typing_timer.timeout.connect(_on_typing_timer)
	pause_timer = Timer.new()
	add_child(pause_timer)
	pause_timer.one_shot = true
	pause_timer.timeout.connect(_on_pause_finished)
	start_next_segment()

func start_next_segment():
	if current_segment >= text_segments.size():
		return
	
	var segment = text_segments[current_segment]
	text_label.text = ""
	text_label.visible = true
	current_char = 0
	typing_timer.start()

func _on_typing_timer():
	var segment = text_segments[current_segment]
	if current_char < segment["text"].length():
		text_label.text += segment["text"][current_char]
		current_char += 1
	else:
		typing_timer.stop()
		if segment["pause_after"] > 0:
			pause_timer.wait_time = segment["pause_after"]
			pause_timer.start()
		else:
			_on_pause_finished()

func _on_pause_finished():
	current_segment += 1
	start_next_segment()

func _process(delta: float) -> void:
	pass
