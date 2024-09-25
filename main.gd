extends Node2D

@export var player_scene: PackedScene
@export var ball_scene: PackedScene

const P1_START_POSITION:Vector2 = Vector2(10,307)
const P2_START_POSITION:Vector2 = Vector2(1270,455)

var ball_acceleration: int = 50


func _ready() -> void:
	reset()

func _process(_delta: float) -> void:
	pass


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
	$UI.p1_score = 0
	$UI.p2_score = 0

func start_game():
	var ball = ball_scene.instantiate()
	ball.position = Vector2(640, 360)  # Field center
	ball.velocity = Vector2(randf_range(-1, 1), randf_range(-0.1, 0.1)).normalized() # Ball starts with a random direction
	add_child(ball)
	
	await get_tree().create_timer(1.0).timeout



func _on_speed_check_body_entered(_body: Node2D) -> void:
	if is_instance_valid($Ball):
		$Ball.speed += ball_acceleration


func _on_left_goal_zone_body_entered(body: Node2D) -> void:
	if body == $Ball:
		$Ball.queue_free()
		$UI.p2_score += 1
		await get_tree().create_timer(0.6).timeout
		$UI.start_countdown()
		
		#A IMPLEMENTER
		#$UI/WinText.text = "PLAYER 2 WINS!"
		#await get_tree().create_timer(1.0).timeout
		#reset()
		#$UI/StartButton.show()

func _on_right_goal_zone_body_entered(body: Node2D) -> void:
	if body == $Ball:
		$Ball.queue_free()
		$UI.p1_score += 1
		await get_tree().create_timer(0.6).timeout
		$UI.start_countdown()
		
		#A IMPLEMENTER
		#$UI/WinText.text = "PLAYER 1 WINS!"
		#await get_tree().create_timer(1.0).timeout
		#reset()
		#$UI/StartButton.show()

func _on_ui_start_button_pressed() -> void:
	$UI/WinText.hide()
	$UI.start_countdown()

func _on_ui_countdown_finished() -> void:
	start_game()
