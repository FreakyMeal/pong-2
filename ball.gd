extends RigidBody2D

var speed = 1000
var direction = Vector2.ZERO

signal collided

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(512, 300)  # Centre du terrain, par exemple
	#var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	#direction = random_direction
	direction = Vector2.LEFT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	apply_impulse(Vector2.RIGHT, Vector2.RIGHT * speed * delta)

func _on_body_entered(body: Node) -> void:
	collided.emit(body)
