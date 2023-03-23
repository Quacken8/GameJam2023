extends RigidBody2D

var numberOCollisions = 0
var lifetime = 0.3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var collision = move_and_collide(linear_velocity*delta)
	if is_instance_valid(collision):
		var collider = collision.get_collider()
		if collider.is_in_group("Enemies"): # check if hit enemy
			collider.hit()
			queue_free()
		elif collider.is_in_group("Bullets"): pass
		elif $Lifetimer.is_stopped(): $Lifetimer.start(lifetime)



func _on_lifetimer_timeout():
	queue_free()
