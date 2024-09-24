extends Node2D

@export var player_scene: PackedScene
@export var ball_scene: PackedScene

var direction:Vector2 = Vector2(1,0)

const P1_START_POSITION:Vector2 = Vector2(10,307)
const P2_START_POSITION:Vector2 = Vector2(1270,455)

var p1_score: int = 0
var p2_score: int = 0

var ball_acceleration: int = 50


func _ready() -> void:
	reset()

func _process(_delta: float) -> void:
	$P1Score.text = str(p1_score)
	$P2Score.text = str(p2_score)


func reset():
	get_tree().call_group("players", "queue_free")
	set_players()
	reset_score()

func set_players():
	var player1 = player_scene.instantiate()
	player1.position = P1_START_POSITION
	player1.up_key = "up_player_1"
	player1.down_key = "down_player_1"
	
	var player2 = player_scene.instantiate()
	player2.position = P2_START_POSITION
	player2.up_key = "up_player_2"
	player2.down_key = "down_player_2"
	
	add_child(player1)
	add_child(player2)


func reset_score():
	p1_score = 0
	p2_score = 0

func start_game():
	var ball = ball_scene.instantiate()
	ball.position = Vector2(640, 360)  # Field center
	ball.velocity = Vector2(randf_range(-1, 1), randf_range(-0.1, 0.1)).normalized() # Ball starts with a random direction
	add_child(ball)

func _on_speed_check_body_entered(_body: Node2D) -> void:
	if is_instance_valid($Ball):
		$Ball.speed += ball_acceleration


func _on_left_goal_zone_body_entered(body: Node2D) -> void:
	if body == $Ball:
		$Ball.queue_free()
		p2_score += 1


func _on_right_goal_zone_body_entered(body: Node2D) -> void:
	if body == $Ball:
		$Ball.queue_free()
		p1_score += 1


func _on_button_pressed() -> void:
	start_game()
	$StartButton.hide()
