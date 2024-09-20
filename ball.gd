extends RigidBody2D

var speed = 300
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_ball()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_ball()

func start_ball():
	position = Vector2(512, 300)  # Centre du terrain, par exemple
	var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	velocity = random_direction

func move_ball():
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity * get_process_delta_time())
