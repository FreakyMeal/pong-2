extends Line2D

@export var length:int = 50
var point := Vector2()

@export var color_slow:Color
@export var color_fast:Color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = Vector2(0,0)
	
	point = $"..".position
	
	add_point(point)
	
	while get_point_count() > length: remove_point(0)
	
	update_trail_color()

func update_trail_color():
	# Calculate speed ratio between min speed and max speed of the ball
	var speed_ratio = clamp(($"..".speed - $"..".starting_speed) / ($"..".max_speed - $"..".starting_speed), 0, 1)

	# Interpolate between color_slow and color_fast
	var new_color = color_slow.lerp(color_fast, speed_ratio)
	
	# Set new color gradient
	gradient.set_color(1, new_color)
