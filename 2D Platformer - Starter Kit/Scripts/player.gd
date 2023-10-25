extends CharacterBody2D

# --------- VARIABLES ---------- #

@export_category("Player Properties") # You can tweak these changes according to your likings

# FLOATING MOVEMENT VARIABLES ------------------
@export var move_speed : float = 300 # original = 400 - X AXIS MOVEMENT SPEED
@export var jump_force : float = -350 # original = 600 - FORCE GOING DOWNWARD WHEN PLAYER PRESSES SPACE BAR
@export var gravity : float = -5 # original = 30 - FLOATING SPEED VARIABLE, MOVING UPWARD
var jump_direction = -1 #based on up and down input will change to 1 or -1

@export var max_jump_count : int = 2
var jump_count : int = 1

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
@export var double_jump : = false

var is_grounded : bool = false
var can_hug : bool = false
var huggable_body: AnimatedSprite2D
var is_hugging: bool = false

var hug_count: int = 0

@onready var player_sprite = $AnimatedSprite2D
@onready var spawn_point = %SpawnPoint
@onready var particle_trails = $ParticleTrails
@onready var death_particles = $DeathParticles
@onready var hug_particles = $HugParticles
@onready var arrow_up: = $ArrowUp
@onready var arrow_down: =  $ArrowDown

#TRY ATTACHING THE HUGGABLE NPC TO THE PLAYER ???


# --------- BUILT-IN FUNCTIONS ---------- #

func _process(_delta):
	# Calling functions
	movement()
	player_animations()
	flip_player()
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact") and can_hug and not is_hugging:
		hug()
	elif Input.is_action_just_pressed("Interact") and is_hugging:
		let_go()

# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->
func movement():
	# Gravity
	velocity.y += gravity
	
	handle_jumping()
	
	# Move Player
	var up_down_input = Input.get_axis("Down", "Up")
	handle_arrow(up_down_input)
	jump_direction = up_down_input

		
	var inputAxis = Input.get_axis("Left", "Right")
	velocity = Vector2(inputAxis * move_speed, velocity.y)
	move_and_slide()

# Handles jumping functionality (double jump or single jump, can be toggled from inspector)
func handle_jumping():
	if Input.is_action_just_pressed("Jump"):
		jump()

# Player jump
func jump():
	jump_tween()
	AudioManager.jump_sfx.play()
	if(jump_direction != 0):
		velocity.y = jump_force * jump_direction
	else:
		velocity.y = -jump_force
func handle_arrow(up_down_input):
	# Showing Up / Down Arrow
	if up_down_input > 0:
		arrow_up.visible = true
		arrow_down.visible = false
	else:
		arrow_down.visible = true
		arrow_up.visible = false
	
# Player "Hug" / Interact
func hug():
	is_hugging = true
	player_sprite.play("Hug")
	#GameManager.add_score()
	huggable_body.hug()
	#huggable_body.hug_sprite.play("Hugged")

func let_go():
	is_hugging = false
	huggable_body.let_go()

# Handle Player Animations
func player_animations():
	particle_trails.emitting = true
	
	if not is_hugging:
		player_sprite.play('Walk')
	else:
		player_sprite.play("Hug")

# Flip player sprite based on X velocity
func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false

# Tween Animations
func death_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
	await tween.finished
	global_position = spawn_point.global_position
	await get_tree().create_timer(0.3).timeout
	AudioManager.respawn_sfx.play()
	respawn_tween()

func respawn_tween():
	var tween = create_tween()
	tween.stop(); tween.play()
	tween.tween_property(self, "scale", Vector2.ONE, 0.15) 

func jump_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.7, 1.4), 0.1)
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)

# --------- SIGNALS ---------- #

# Reset the player's position to the current level spawn point if collided with any trap
func _on_collision_body_entered(_body):
	if _body.is_in_group("Traps"):
		AudioManager.death_sfx.play()
		death_particles.emitting = true
		death_tween()

func _on_area_2d_hug_area_entered(area): # within reach of a huggable npc
	if area.is_in_group("Friend"):
		huggable_body = area.get_parent()
		can_hug = true

func _on_area_2d_hug_area_exited(area): # not within reach of huggable npc
	if area.is_in_group("Friend"):
		can_hug = false
