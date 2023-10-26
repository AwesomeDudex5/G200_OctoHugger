# This script is an autoload, that can be accessed from any other script!

extends Node2D

signal savedFriend(totalSaved : float)

var score : int = 0
var friendSaved = 0

# Adds 1 to score variable
func add_score():
	score += 1
	
func addToGate():
	print("Adding to Gate")
	friendSaved += 1
	emit_signal("savedFriend", friendSaved)

func checkGate(numToUnlock):
	if(friendSaved >= numToUnlock):
		return true
	else:
		return false


# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
