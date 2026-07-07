extends CanvasLayer
signal start_game

@onready var score_label = $ScoreLabel
@onready var start_button = $StartButton
@onready var message = $Message
@onready var message_timer = $MessageTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	start_game.emit()
	start_button.hide()

func _on_message_timer_timeout() -> void:
	message.hide()


func show_message(text):
	message.text = text
	message.show()
	message_timer.start()

func game_over():
	show_message("Game Over")
	await message_timer.timeout
	
	message.text = "Dodge the creeps!"
	message.show()
	await get_tree().create_timer(1.0).timeout
	start_button.show()
	
func update_score(score):
	score_label.text=str(score)
	
