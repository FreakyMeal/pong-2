extends Line2D

@export var length:int = 50
var point: = Vector2()

# To add: trail that becomes blue when the ball speeds up
#@export var color_slow:Color
#@export var color_fast:Color
#@export var max_speed:int


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = Vector2(0,0)
	
	point = get_parent().position
	
	add_point(point)
	while get_point_count() > length:
		remove_point(0)
	
