extends Node

@export var player: PackedScene

const P1_START_POSITION:Vector2 = Vector2(10,307)
const P2_START_POSITION:Vector2 = Vector2(1270,455)

func _ready() -> void:
	reset()

func _process(delta: float) -> void:
	pass

func reset():
	var player1 = player.instantiate()
	var player2 = player.instantiate()
	
	player1.position = P1_START_POSITION
	player2.position = P2_START_POSITION
	
	add_child(player1)
	add_child(player2)
