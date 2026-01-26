extends Control

@onready var text_label = $Text
@onready var typewriter_sfx = $typewriter_sfx

var current_segment = 0
var current_char = 0
var typing_speed = 0.1
var typing_timer: Timer
var pause_timer: Timer
var text_segments = [
	{"text": "I used to think time was something you lost slowly,", "pause_after": 1.0},
	{"text": "Days passing.. Moments slipping away.", "pause_after": 0.5},
	{"text": "I was wrong.", "pause_after": 1.0},
	{"text": "Time doesn't fade... it's taken,", "pause_after": 1.0},
	{"text": "The Chronarcs took it.", "pause_after": 1.9},
	{"text": "They locked it in place... and called it order.", "pause_after": 1.0},
	{"text": "Now every second matters,", "pause_after": 1.0},
	{"text": "Not because it's rare.. but because it hurts to spend.", "pause_after": 1.0},
	{"text": "I can't stop that,", "pause_after": 1.0},
	{"text": "I can only point the way.", "pause_after": 1.5},
	{"text": "Use what we have left.", "pause_after": 1.0},
	{"text": " ", "pause_after": 0.4}
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
		if segment["text"][current_char] != " ":
			typewriter_sfx.pitch_scale = randf_range(0.7, 0.8)
			typewriter_sfx.play()
		
		current_char += 1
	else:
		typing_timer.stop()
		typewriter_sfx.stop()
		if segment["pause_after"] > 0:
			pause_timer.wait_time = segment["pause_after"]
			pause_timer.start()
		else:
			_on_pause_finished()

func _on_pause_finished():
	current_segment += 1
	start_next_segment()
	if current_segment == 12:
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("SkipScene"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
