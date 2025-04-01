extends CanvasLayer

signal resume_game
signal controls
signal quit_game
signal toggles

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_resume_button_pressed() -> void:
	resume_game.emit()

func _on_controls_button_pressed() -> void:
	controls.emit()

func _on_quit_button_pressed() -> void:
	quit_game.emit()

func _on_toggles_button_pressed() -> void:
	toggles.emit()
