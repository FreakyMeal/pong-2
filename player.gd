extends Area2D

var speed:int = 300
var direction:Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
		$Move_handler.move_player()
