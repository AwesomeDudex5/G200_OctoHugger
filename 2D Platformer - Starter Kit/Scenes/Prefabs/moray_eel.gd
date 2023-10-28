extends Node2D

@onready var animPlayer = $AnimationPlayer
@onready var detectArea = $"Detection Area"
@onready var hurtArea = $"Hurt Area"
var originalDetecPosition

@export var moveSpeed : float
var originalPosition : Vector2
var playerBody : CharacterBody2D
var targetPosition : Vector2
var isChasing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	originalPosition = position
	originalDetecPosition = detectArea.global_position
	animPlayer.play("default")
	
	detectArea.connect("area_entered", _on_detection_area_body_entered)
	detectArea.connect("area_exited", _on_detection_area_body_exited)

	hurtArea.connect("area_entered", _on_hurt_area_body_entered)
	hurtArea.connect("area_exited",_on_hurt_area_body_exited)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	detectArea.global_position = originalDetecPosition
	if(isChasing == true):
		targetPosition = playerBody.position
		position = position.move_toward(targetPosition, delta * moveSpeed)
	else:
		position = position.move_toward(originalPosition, delta * moveSpeed)


# it's Kai I added these: --------------------------------------------------------------------
func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		isChasing = true
		playerBody = body
		
func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		isChasing = false
		targetPosition = originalPosition


func _on_hurt_area_body_entered(body): # Hurt area 
	if body.is_in_group("Player"):
		pass


func _on_hurt_area_body_exited(body):
	if body.is_in_group("Player"):
		pass



