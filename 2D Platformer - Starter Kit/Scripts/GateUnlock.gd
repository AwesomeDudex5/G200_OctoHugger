extends Node

@export var numberToUnlock : float = 1
var numberOfFriendSaved : float = 0

@onready var animationPlayer = $AnimationPlayer

@onready var newSpawnPoint = $NextSpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("savedFriend", updateGateCount)
	#self.connect("savedFriend", self, "updatedGateCount")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateGateCount(friendSaved):
	numberOfFriendSaved = friendSaved
	if(numberToUnlock <= numberOfFriendSaved):
		animationPlayer.play("Unlock_Animation")
		GameManager.emit_signal("setNewSpawnPoint", newSpawnPoint)
		$RigidBody2D/CollisionShape2D.disabled = true
		$RigidBody2D/CollisionShape2D.set_deferred("disabled", true)
		$RigidBody2D/CollisionShape2D.visible = false

