extends Timer

@export var spawnTime = 1
@onready var spawners = get_tree().get_nodes_in_group("Spawners")
var enemyScene = preload("res://enemy.tscn")

func _on_timeout():
	var spawner = spawners.pick_random()
	var enemyInstance = enemyScene.instantiate()
	print(spawner.global_position)
	enemyInstance.startingPosition = spawner.global_position
	get_parent().add_child(enemyInstance)
	start(spawnTime)
