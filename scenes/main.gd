extends Control

@onready var options: Panel = $Options

func _ready() -> void:
	options.visible = false
	options.process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PauseMenu"):
		options.visible = true
		get_tree().paused = true

func _on_back_pressed() -> void:
	options.visible = false
	get_tree().paused = false


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
