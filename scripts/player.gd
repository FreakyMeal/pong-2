extends CharacterBody2D

@export var player_id:int = 0
@export var speed:int = 500
var direction: = Vector2.ZERO

@export var up_key:String = ""
@export var down_key:String = ""
@export var hold_key:String = ""

var is_holding_ball:bool = false

signal hold_key_pressed
signal hold_key_released

func _ready() -> void:
	if player_id == 1:
		up_key = "up_player_1"
		down_key = "down_player_1"
		hold_key = "hold_player_1"
	elif player_id == 2:
		up_key = "up_player_2"
		down_key = "down_player_2"
		hold_key = "hold_player_2"

func _process(delta: float) -> void:
	move_and_collide(velocity * delta)
	
	if Input.is_action_pressed(up_key):
		direction = Vector2.UP
		position += direction * speed * delta
	if Input.is_action_pressed(down_key):
		direction = Vector2.DOWN
		position += direction * speed * delta
	
	if Input.is_action_pressed(hold_key):
		hold_key_pressed.emit()
		is_holding_ball = true
	if Input.is_action_just_released(hold_key):
		hold_key_released.emit()
		is_holding_ball = false
