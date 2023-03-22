extends RigidBody2D

var velocity = Vector2.ZERO
var numberOCollisions = 0
var lifetime = 0.3
@onready var timerNode = get_node("Lifetimer")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print(position)
	var collision = move_and_collide(velocity*delta)
	if collision != null and timerNode.paused:
		if collision.get_collider() == null: # check if hit enemy
			queue_free()
		else: timerNode.start(lifetime)



func _on_lifetimer_timeout():
	queue_free()
