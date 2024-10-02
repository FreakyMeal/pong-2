extends RigidBody2D

@export var speed:float = 500.0
@export var acceleration:float = 1.05
var direction := Vector2.ZERO

var is_held:bool = false
var player_holding: Node2D = null
@export var hold_distance: float = 60.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_held:
		var collision = move_and_collide(direction * speed * delta)
		
		if collision:
			var collider = collision.get_collider()
			direction = direction.bounce(collision.get_normal())
			
			if collider.is_in_group("players"):
				speed *= acceleration
	else:
		update_held_position()


# Ball starts with a random horizontal-ish direction
func move():
	var x = [-1,1].pick_random() # Pick a random left or right start direction
	direction = Vector2(x, randf_range(-0.5, 0.5)).normalized()

func reset_position():
	position = Vector2(640, 360)  # Field center

func hold(player: Node2D):
	is_held = true
	$AnimationPlayer.play("held")
	player_holding = player

func release():
	is_held = false
	$AnimationPlayer.stop()
	player_holding = null

# Check if ball is near a player
func is_near_player(player: Node2D) -> bool:
	return position.distance_to(player.position) < hold_distance

func update_held_position():
	if player_holding.name == "Player1":
		position = player_holding.position + Vector2(hold_distance,0)
	if player_holding.name == "Player2":
		position = player_holding.position - Vector2(hold_distance,0)
		
