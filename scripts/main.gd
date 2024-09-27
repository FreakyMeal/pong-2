extends Node2D

@export var player_scene: PackedScene
@export var ball_scene: PackedScene

const P1_START_POSITION:= Vector2(10,307)
const P2_START_POSITION: = Vector2(1270,455)

var ball_acceleration: int = 50

var ball = null
var player1 = null
var player2 = null

func _ready() -> void:
	reset()

func _process(_delta: float) -> void:
	pass


func reset():
	get_tree().call_group("players", "queue_free")
	set_players()
	reset_score()
	$UI/TextDisplay.show()
	$UI/TextDisplay.text = "First to 5 wins"

func set_players():
	player1 = player_scene.instantiate()
	player1.position = P1_START_POSITION
	player1.up_key = "up_player_1"
	player1.down_key = "down_player_1"
	player1.hold_key = "hold_player_1"
	
	player2 = player_scene.instantiate()
	player2.position = P2_START_POSITION
	player2.up_key = "up_player_2"
	player2.down_key = "down_player_2"
	player2.hold_key = "hold_player_2"
	
	add_child(player1)
	add_child(player2)


func reset_score():
	$UI.p1_score = 0
	$UI.p2_score = 0

func start_game():
	ball = ball_scene.instantiate()
	ball.position = Vector2(640, 360)  # Field center
	ball.velocity = Vector2(randf_range(-1, 1), randf_range(-0.1, 0.1)).normalized() # Ball starts with a random direction
	add_child(ball)
	
	await get_tree().create_timer(1.0).timeout



func _on_speed_check_body_entered(_body: Node2D) -> void:
	if is_instance_valid(ball):
		ball.speed += ball_acceleration

func _on_left_goal_zone_body_entered(body: Node2D) -> void:
	if body == ball:
		$UI.p2_score += 1
		ball.queue_free()
		
		if $UI.p2_score >= 5:
			$UI/TextDisplay.text = "PLAYER 2 WINS!"
			$UI/TextDisplay.show()
			await get_tree().create_timer(1.0).timeout
			$UI/StartButton.show()
		else:
			await get_tree().create_timer(0.6).timeout
			$UI.start_countdown()


func _on_right_goal_zone_body_entered(body: Node2D) -> void:
	if body == ball:
		$UI.p1_score += 1
		ball.queue_free()
		
		if $UI.p1_score >= 5:
			$UI/TextDisplay.text = "PLAYER 1 WINS!"
			$UI/TextDisplay.show()
			await get_tree().create_timer(1.0).timeout
			$UI/StartButton.show()
		else:
			await get_tree().create_timer(0.6).timeout
			$UI.start_countdown()


func _on_ui_start_button_pressed() -> void:
	reset_score()
	$UI/TextDisplay.hide()
	$UI.start_countdown()

func _on_ui_countdown_finished() -> void:
	start_game()
