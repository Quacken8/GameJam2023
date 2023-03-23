extends "res://guy.gd"

@onready var health = 4
@onready var playerNode = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	var towardsPlayer = playerNode.global_position - global_position
	velocity = towardsPlayer.normalized()*maxSpeed
	move_and_slide()

func hit():
	health -= 1
	if health<0:
		queue_free()
