extends Sprite2D

var move_direction: = 0

@export var move_speed: int = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	if frame == 12 or frame == 14:
		move_direction = -1 # move left
	elif frame == 13 or frame == 15:
		move_direction = 1 # move right
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += move_direction * move_speed
		
