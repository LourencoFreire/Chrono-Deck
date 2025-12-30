extends TextureProgressBar

@export var total_time: float = 75
var time_left: float

func _ready():
	time_left = 60
	max_value = total_time
	value = 60
	$"../../Countdown/Timer".start()
	var posx = get_viewport().size.x - $"../../Countdown/countdownLabel".size.x
	$"../../Countdown/countdownLabel".position = Vector2(posx, 260) / 2

func time_left_to_zero():
	var time_left = $"../../Countdown/Timer".time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

func _process(delta: float):
	time_left -= delta
	time_left = max(time_left, 0.0)
	value = time_left
	$"../../Countdown/countdownLabel".text = "%02d:%02d" % time_left_to_zero()
