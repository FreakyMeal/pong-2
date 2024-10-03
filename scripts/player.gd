extends CharacterBody2D

class_name Player

@export var player_id: int = 0
@export var speed: int = 500
@export var up_key: String = ""
@export var down_key: String = ""
@export var hold_key: String = ""

var direction: Vector2 = Vector2.ZERO
var is_holding_ball: bool = false

signal hold_key_pressed
signal hold_key_released

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
