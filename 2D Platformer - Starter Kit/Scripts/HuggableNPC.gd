extends CharacterBody2D

@export var canMove : float #random token to set if NPC will move or not
@export var max_movement_speed = 200
var stop_speed = 0
var current_movement_speed
@export var movement_range = 100
@export var direction = 1

var postive_range : float
var negative_range : float

var player
var jump_velocity
var jump_direction
var jump_force : float = -350
var initial_velocity = 0

#--------
@onready var hug_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer
var hugged : bool = false

func _ready():
	postive_range = position.x + movement_range
	negative_range = position.x - movement_range
	max_movement_speed = randf_range(50, max_movement_speed)
	current_movement_speed = max_movement_speed
	canMove = (randi() % 2)


func _process(delta):
	# Move the NPC back and forth
	#var velocity = Vector2(movement_speed * direction, 0)
	#move_and_slide()
	if(canMove > 0):
		var new_x = position.x + (current_movement_speed * direction * delta)
		if new_x > (postive_range) or new_x < (negative_range):
			direction *= -1
		position.x = new_x
	
#	if(hugged == true && player != null):
#		velocity.y = jump_force * jump_direction
#		velocity = Vector2(0, velocity.y)
#	else:
#		velocity.y = initial_velocity
#	move_and_slide()
		
#	if (hugged):  # NOT WORKING - npc following player as it floats
#		position.y = player.position.y
	
		


func _set_hug(playerDirection, playerVelocity):
	hugged = true	
	current_movement_speed = stop_speed
	jump_velocity = playerVelocity
	jump_direction = playerDirection
	


#func _physics_process(delta):
#
#	velocity.x += movement_speed
#
#	flip_sprite()
#	flip_direction()
#	move_and_slide()
#
#func flip_direction():
#	if velocity.x == 0:
#		movement_speed = -movement_speed
#
#func flip_sprite():
#	if velocity.x < 0: 
#		hug_sprite.flip_h = true
#	elif velocity.x > 0:
#		hug_sprite.flip_h = false
#
func huggable():
	return
#
#func _on_timer_timeout():
#	add_child(load("res://Scenes/Prefabs/huggable_npc.tscn").instantiate())
#	#queue_free()

func _on_hug_collision_body_entered(body):
	if body.has_method("player"):
		player = body

func _on_hug_collision_body_exited(body):
	current_movement_speed = max_movement_speed
	player = null
	hugged = false


