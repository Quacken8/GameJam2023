extends  "res://guy.gd"

const lerpWeight = 7e-1
var mousePosition = Vector2.ZERO
var toMouse = Vector2.ZERO
var angleToMouse = 0.0
const muzzleVelocity = 700
const bulletSpread = PI/6
const bulletNumber = 4
const pushForce = 1000

var bulletScene = preload("res://bullet.tscn")
@onready var muzzlePozition = get_node("Gun/Muzzless").position

func _ready():
	startingPosition = Vector2(500, 500)

func _physics_process(delta):
	var leftPressed =  int(Input.is_action_pressed("left"))
	var rightPressed = int(Input.is_action_pressed("right"))
	var upPressed =    int(Input.is_action_pressed("up"))
	var downPressed =  int(Input.is_action_pressed("down"))
	
	var movementDirection = upPressed*Vector2.UP + downPressed*Vector2.DOWN + leftPressed*Vector2.LEFT + rightPressed*Vector2.RIGHT
	velocity = velocity.lerp(movementDirection.normalized()*maxSpeed, lerpWeight)
	
	if self.move_and_slide(): # true if collided
		for i in self.get_slide_collision_count():
			var col = self.get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				col.get_collider().apply_force(col.get_normal() * pushForce)
	
	if Input.is_action_just_pressed("mouseClick"):
		shoot()

func _process(delta):
	toMouse = mousePosition - global_position
	angleToMouse = toMouse.angle()
	rotation = angleToMouse + PI/2

func _input(event):
	if event is InputEventMouseMotion:
		mousePosition = event.global_position

func shoot():
	for i in range(bulletNumber):
		var currentAngle =  (i-0.5) * bulletSpread/bulletNumber
		var directionVector = toMouse.rotated(currentAngle)
		var bulletInstance = bulletScene.instantiate()
		bulletInstance.set_linear_velocity(directionVector.normalized()*muzzleVelocity)
		bulletInstance.position = position + muzzlePozition.rotated(rotation)
		bulletInstance.add_to_group("Bullets")
		get_parent().add_child(bulletInstance)



func _on_vision_area_body_entered(body):
	if body.is_in_group("Enemies"):
		body.visible = true


func _on_vision_area_body_exited(body):	
	if body.is_in_group("Enemies"):
		body.visible = false
