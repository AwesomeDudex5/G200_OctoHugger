extends CharacterBody2D

@export var canMove : float #random token to set if NPC will move or not
@export var movement_speed = 200
@export var movement_range = 100
@export var direction = 1

var postive_range : float
var negative_range : float

#--------
@onready var hug_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer
var hugged : bool = false

func _ready():
	postive_range = position.x + movement_range
	negative_range = position.x - movement_range
	movement_speed = randf_range(50, movement_speed)
	canMove = (randi() % 2)


func _process(delta):
	# Move the NPC back and forth
	#var velocity = Vector2(movement_speed * direction, 0)
	#move_and_slide()
	if(canMove > 0):
		var new_x = position.x + (movement_speed * direction * delta)
		if new_x > (postive_range) or new_x < (negative_range):
			direction *= -1
		position.x = new_x


func _set_hug():
	hugged = true	
	movement_speed = 0


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
#func huggable():
#	return
#
#func _on_timer_timeout():
#	add_child(load("res://Scenes/Prefabs/huggable_npc.tscn").instantiate())
#	#queue_free()

