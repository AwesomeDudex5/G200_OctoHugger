extends Node2D

@onready var animPlayer = $AnimationPlayer
@onready var detectArea = $"Detection Area"
@onready var hurtArea = $"Hurt Area"

var moveSpeed

# Called when the node enters the scene tree for the first time.
func _ready():
	animPlayer.play("default")
	
	detectArea.connect("area_entered", _on_detection_area_entered)
	detectArea.connect("area_exited", _on_detection_area_exited)

	hurtArea.connect("area_entered", _on_kill_area_entered)
	hurtArea.connect("area_exited", _on_kill_area_exited)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_detection_area_entered(body):
	pass
		# The player has entered the detection area
		# Handle player detection logic here

func _on_detection_area_exited(body):
	pass
		# The player has exited the detection area
		# Handle player exit logic here

func _on_kill_area_entered(body):
	pass
		# The player has entered the kill area
		# Handle player kill logic here

func _on_kill_area_exited(body):
	pass
		# The player has exited the kill area
		# Handle player exit logic here
		

func _on_area_entered(area):
	if area.is_in_group("Player"):
		print("Deteced Player")
