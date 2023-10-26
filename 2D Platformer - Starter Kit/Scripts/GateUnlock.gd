extends Node

@export var numberToUnlock : float = 1
var numberOfFriendSaved : float = 0

@onready var animationPlayer = $AnimationPlayer

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
		$RigidBody2D/CollisionShape2D.visible = false
		



func _on_game_manager_saved_friend(totalSaved):
	numberOfFriendSaved = totalSaved
	if(numberToUnlock <= numberOfFriendSaved):
		animationPlayer.play("Unlock_Animation")
		$RigidBody2D/CollisionShape2D.visible = false
