extends Node2D

@export var up_key:String = ""
@export var down_key:String = ""

func move_player():
	if Input.is_action_pressed(up_key):
		$"..".direction = Vector2.UP
		$"..".position += $"..".direction * $"..".speed * get_process_delta_time()
	if Input.is_action_pressed(down_key):
		$"..".direction = Vector2.DOWN
		$"..".position += $"..".direction * $"..".speed * get_process_delta_time()
