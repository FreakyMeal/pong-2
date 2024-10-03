extends Node2D

@onready var ball_scene: PackedScene = preload("res://scenes/ball.tscn")
var ball = null

func _ready() -> void:
	reset()

# func _process(_delta: float) -> void:
# 	pass
func reset_score():
	$UI.p1_score = 0
	$UI.p2_score = 0

func reset():
	reset_score()
	$UI/TextDisplay.show()

	$UI/TextDisplay.text = "FIRST TO 5 WINS"

func start_game():
	ball = ball_scene.instantiate()
	ball.move()
	add_child(ball)
	await get_tree().create_timer(1.0).timeout


func _on_left_goal_zone_body_entered(body: Ball) -> void:
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


func _on_right_goal_zone_body_entered(body: Ball) -> void:
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

func _on_player_1_hold_key_pressed() -> void:
	if is_instance_valid(ball) and ball.is_near_player($Player1): ball.hold($Player1)

func _on_player_2_hold_key_pressed() -> void:
	if is_instance_valid(ball) and ball.is_near_player($Player2): ball.hold($Player2)

func _on_player_1_hold_key_released() -> void:
	if is_instance_valid(ball) and ball.player_holding == $Player1: ball.release()

func _on_player_2_hold_key_released() -> void:
	if is_instance_valid(ball) and ball.player_holding == $Player2: ball.release()
