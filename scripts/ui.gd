extends Control

var p1_score: int = 0
var p2_score: int = 0

signal start_button_pressed
signal countdown_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$P1Score.text = str(p1_score)
	$P2Score.text = str(p2_score)


func _on_start_button_pressed() -> void:
	start_button_pressed.emit()
	$StartButton.hide()
	$TextDisplay.hide()
	$Keys.hide()

func start_countdown():
	$StartTimer.show()
	var timer_count:int = 3
	for i in timer_count:
		$StartTimer.text = str(timer_count)
		await get_tree().create_timer(0.6).timeout
		timer_count -= 1
	
	$StartTimer.text = "Go!"
	await get_tree().create_timer(0.3).timeout
	$StartTimer.hide()
	countdown_finished.emit()
