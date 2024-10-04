extends ProgressBar

@export var fill_rate:int = 100

var is_filling:bool = false

func _ready():
	pass

func _process(_delta: float) -> void:
	if visible and value < max_value:
		fill()
	elif visible and value > max_value:
		drain()
	elif visible and value == min_value:
		hide()

func fill():
	value += fill_rate * get_process_delta_time()

func drain():
	value -= fill_rate * get_process_delta_time()
