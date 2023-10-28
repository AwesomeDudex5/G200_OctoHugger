# This script is an autoload, that can be accessed from any other script!

extends Node2D

signal savedFriend(totalSaved : float)
signal setNewSpawnPoint(spawnPoint : Marker2D)
signal finishedGame()

var score : int = 0
var friendSaved = 0
@export var totalFriends : float = 14

@onready var current_spawn_point : Marker2D = %SpawnPoint

# Adds 1 to score variable
func add_score():
	score += 1
	
func addToGate():
	print("Saved Friends: ", friendSaved)
	friendSaved += 1
	score += 1
	emit_signal("savedFriend", friendSaved)
	if(friendSaved >= totalFriends):
		emit_signal("finishedGame")

func checkGate(numToUnlock):
	if(friendSaved >= numToUnlock):
		return true
	else:
		return false


# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
