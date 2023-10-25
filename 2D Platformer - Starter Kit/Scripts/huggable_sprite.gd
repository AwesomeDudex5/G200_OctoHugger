extends AnimatedSprite2D

@export var canMove : float #random token to set if NPC will move or not
@export var max_movement_speed = 200
var stop_speed = 0
var current_movement_speed
@export var movement_range = 100
@export var direction = 1
@export var follow_speed: = 1000

var gravity = 5
var currentVelocity = 0
var reachedAscendZone : bool

var postive_range : float
var negative_range : float

var hugged : bool = false
var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	reachedAscendZone = false
	#determine range of NPC movement and if can move
	randomize()
	postive_range = position.x + movement_range
	negative_range = position.x - movement_range
	max_movement_speed = randf_range(50, max_movement_speed)
	current_movement_speed = max_movement_speed
	canMove = (randi() % 2)
	play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Move the NPC back and forth
	#var velocity = Vector2(movement_speed * direction, 0)
	if(reachedAscendZone == false):
		if(canMove > 0):
			var new_x = position.x + (current_movement_speed * direction * delta)
			if new_x > (postive_range) or new_x < (negative_range):
				direction *= -1
			position.x = new_x
		
		if player and hugged: # following player once "hugged"
			position.x = move_toward(position.x, player.position.x + 100, follow_speed * delta)
			position.y = move_toward(position.y, player.position.y, follow_speed * delta)
	else:
		position.y -= gravity


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		#print(player)
		
func hug():
	hugged = true
	canMove = 0
	#print("hugged")

func let_go():
	hugged = false
	canMove = 1
	#update new ranges
	postive_range = position.x + movement_range
	negative_range = position.x - movement_range
	#print("let go")
	

func set_ascending():
	reachedAscendZone = true
	canMove = 0

