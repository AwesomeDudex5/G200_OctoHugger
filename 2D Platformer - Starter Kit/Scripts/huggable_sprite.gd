extends AnimatedSprite2D

@export var follow_speed : int = 1000

var hugged : bool  = false
var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player and hugged: # following player once "hugged"
		position.x = move_toward(position.x, player.position.x + 100, follow_speed * delta)
		position.y = move_toward(position.y, player.position.y, follow_speed * delta)


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		#print(player)
		
func hug():
	hugged = true
	#print("hugged")

func let_go():
	hugged = false
	#print("let go")
