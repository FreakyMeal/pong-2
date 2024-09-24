extends RigidBody2D

var speed = 400
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(640, 360)  # Field center
	var random_direction = Vector2(randf_range(-1, 1), randf_range(-0.4, 0.4)).normalized()
	velocity = random_direction



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * speed * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
