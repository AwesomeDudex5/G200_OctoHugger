extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().set_deferred("paused", false)
	visible  = false
	GameManager.connect("finishedGame", setToVisible)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setToVisible():
	get_tree().set_deferred("paused", true)
	visible = true

func _on_button_pressed():
	get_tree().reload_current_scene()
