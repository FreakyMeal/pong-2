extends CharacterBody2D

var speed:int = 300
var direction: = Vector2.ZERO

var up_key:String = ""
var down_key:String = ""

func _process(delta: float) -> void:
	move_and_collide(velocity * delta)
	
	if Input.is_action_pressed(up_key):
		direction = Vector2.UP
		position += direction * speed * delta
	if Input.is_action_pressed(down_key):
		direction = Vector2.DOWN
		position += direction * speed * delta
