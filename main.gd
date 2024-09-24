extends Node2D

@export var player: PackedScene

var direction:Vector2 = Vector2(1,0)

const P1_START_POSITION:Vector2 = Vector2(10,307)
const P2_START_POSITION:Vector2 = Vector2(1270,455)

func _ready() -> void:
	reset()

func _process(_delta: float) -> void:
	pass

func reset():
	get_tree().call_group("players", "queue_free")
	set_players()

func set_players():
	var player1 = player.instantiate()
	player1.position = P1_START_POSITION
	player1.up_key = "up_player_1"
	player1.down_key = "down_player_1"
	
	var player2 = player.instantiate()
	player2.position = P2_START_POSITION
	player2.up_key = "up_player_2"
	player2.down_key = "down_player_2"
	
	add_child(player1)
	add_child(player2)


func _on_goal_zone_body_entered(body: Node2D) -> void:
	if body == $Ball:
		$Ball.queue_free()


func _on_speed_check_body_entered(_body: Node2D) -> void:
	$Ball.speed += 50
