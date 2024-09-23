extends Node2D

@export var player: PackedScene

var screen_size
var pad_size
var direction:Vector2 = Vector2(1,0)

const P1_START_POSITION:Vector2 = Vector2(10,307)
const P2_START_POSITION:Vector2 = Vector2(1270,455)

func _ready() -> void:
	reset()
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	pass

func reset():
	get_tree().call_group("players", "queue_free")
	set_players()

func set_players():
	var player1 = player.instantiate()
	player1.position = P1_START_POSITION
	player1.find_child("Move_handler").up_key = "up_player_1"
	player1.find_child("Move_handler").down_key = "down_player_1"
	
	var player2 = player.instantiate()
	player2.position = P2_START_POSITION
	player2.find_child("Move_handler").up_key = "up_player_2"
	player2.find_child("Move_handler").down_key = "down_player_2"
	
	add_child(player1)
	add_child(player2)

func _on_ball_collided() -> void:
	$Ball.direction = Vector2.UP
