extends CharacterBody2D


@export var movement_speed = -2

#--------
@onready var hug_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func _ready():
	randomize()
	position.y = randi()%720
	position.x = 1110
	print (position.y)
	timer.start()

func _physics_process(delta):

	velocity.x += movement_speed

	flip_sprite()
	flip_direction()
	move_and_slide()
	
func flip_direction():
	if velocity.x == 0:
		movement_speed = -movement_speed
	
func flip_sprite():
	if velocity.x < 0: 
		hug_sprite.flip_h = true
	elif velocity.x > 0:
		hug_sprite.flip_h = false
	
func huggable():
	return

func _on_timer_timeout():
	add_child(load("res://Scenes/Prefabs/huggable_npc.tscn").instantiate())
	#queue_free()

