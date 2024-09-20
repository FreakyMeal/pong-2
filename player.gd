extends Area2D

var speed:int = 300
var p1_direction:Vector2 = Vector2.ZERO
var p2_direction:Vector2 = Vector2.ZERO
var is_player_1:bool = true

func _process(delta: float) -> void:
	if is_player_1:
		move_player_1()
	else:
		move_player_2()

func move_player_1():
	if Input.is_action_pressed("down_player_1"):
		p1_direction = Vector2.DOWN
		position += p1_direction * speed * get_process_delta_time()
	if Input.is_action_pressed("up_player_1"):
		p1_direction = Vector2.UP
		position += p1_direction * speed * get_process_delta_time()


func move_player_2():
	if Input.is_action_pressed("down_player_2"):
		p2_direction = Vector2.DOWN
		position += p2_direction * speed * get_process_delta_time()
	if Input.is_action_pressed("up_player_2"):
		p2_direction = Vector2.UP
		position += p2_direction * speed * get_process_delta_time()
