extends CharacterBody2D

var speed = 350

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(512, 300)  # Centre du terrain
	var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * speed
	velocity = random_direction



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * get_process_delta_time())
	print(str(collision))
	if collision:
		velocity = velocity.bounce(collision.get_normal())
