extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area): #check if body is Friend, set friend to ascend
	if area.is_in_group("Friend"):
		if area.get_parent().has_method("set_ascending"): 
			area.get_parent().set_ascending() # calling huggable_sprite's set_ascending()
			print("ascending friend")
			GameManager.add_score()
	if area.get_parent().is_in_group("Player"):
		area.get_parent().let_go()
