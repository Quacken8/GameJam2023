extends "res://guy.gd"

@onready var health = 2
var weight = 1e-1

const pushForce = 1000

func _physics_process(delta):
	var playerNode = get_tree().get_first_node_in_group("Player")
	var towardsPlayer = playerNode.get_position() - global_position
	var desiredVelocity = towardsPlayer.normalized()*maxSpeed
	velocity = velocity.lerp(desiredVelocity, weight)
	if self.move_and_slide(): # true if collided
		for i in self.get_slide_collision_count():
			var col = self.get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				col.get_collider().apply_force(col.get_normal() * pushForce)

func hit():
	health -= 1
	if health<0:
		queue_free()
