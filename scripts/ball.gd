extends RigidBody2D

class_name Ball

@export var starting_speed:float = 800.0
@export var speed:float = 800.0
@export var max_speed:float = 1800.0
@export var acceleration:float = 1.05
var direction := Vector2.ZERO

var is_held:bool = false
var can_be_held:bool = true
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
				speed = speed * acceleration if speed < max_speed else max_speed
				
				# Ball cannot be held immediately after colliding with a player (not the optimal way to do this)
				can_be_held = false
				await get_tree().create_timer(0.5).timeout
				can_be_held = true
	else:
		update_held_position()


# Ball starts with a random horizontal-ish direction
func move():
	speed = starting_speed
	var x = [-1,1].pick_random() # Pick a random left or right start direction
	direction = Vector2(x, randf_range(-0.5, 0.5)).normalized()

func reset_position():
	position = Vector2(640, 360)  # Field center

func hold(player: Player):
	if can_be_held:
		is_held = true
		player_holding = player
		$BallAnimation.play("held")
		$PowerGauge.show()

func release():
	is_held = false
	$BallAnimation.stop()
	player_holding = null
	$PowerGauge.hide()
	if $PowerGauge.value == 100:
		speed *= 1.5
	$PowerGauge.value = 0
	
	# Send the ball back without colliding with the player
	direction.x *= -1
	
	can_be_held = true

# Check if ball is near a player
func is_near_player(player: Player) -> bool:
	return position.distance_to(player.position) < hold_distance

func update_held_position():
	if player_holding.name == "Player1":
		position = player_holding.position + Vector2(hold_distance,0)
	if player_holding.name == "Player2":
		position = player_holding.position - Vector2(hold_distance,0)
		
