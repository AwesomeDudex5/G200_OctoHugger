extends  Node2D

@export var NPC_Prefab : PackedScene
@export var spawnRange = 1000
@export var spawnAmount = 8

func _ready():
	spawn_NPCs()

func spawn_NPCs():
	for n in spawnAmount:
		var randX = randf_range(position.x - spawnRange, position.x + spawnRange)
		var randY = randf_range(position.y - spawnRange, position.y + spawnRange)
		var newInstance = NPC_Prefab.instantiate()
		# print("Pos: ", Vector2(randX, randY))
		newInstance.position = Vector2(randX, randY)
		add_child(newInstance)
	
