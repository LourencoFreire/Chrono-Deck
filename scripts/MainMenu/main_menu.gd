extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options
@onready var background: Panel = $Background


func _ready():
	main_buttons.visible = true
	options.visible = false
	$ChronoDeckLogo.visible = true
	background.modulate = Color("#787878")

func _process(_delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/first_monologue.tscn")


func _on_settings_pressed() -> void:
	main_buttons.visible = false
	options.visible = true
	var style = StyleBoxTexture.new()
	style.texture = load("res://assets/images2/MainScreenBlurForReal.png")
	background.add_theme_stylebox_override("panel", style)
	$ChronoDeckLogo.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_options_pressed() -> void:
	_ready()
	var style = StyleBoxTexture.new()
	style.texture = load("res://assets/images2/MainScreen.png")
	background.add_theme_stylebox_override("panel", style)

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
	
