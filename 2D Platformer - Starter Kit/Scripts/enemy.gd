extends CharacterBody2D


var speed = 20
#var tween: = get_tree().create_tween()



func _physics_process(delta):
	#tween.tween_property(self, "position.y", speed, 2.0).set_trans(Tween.TRANS_SINE)
	move_and_slide()
