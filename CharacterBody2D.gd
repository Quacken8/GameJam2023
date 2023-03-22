extends  "res://guy.gd"

const lerpWeight = 7e-1

var mousePosition = Vector2.ZERO
var toMouse = Vector2.ZERO
var angleToMouse = 0.0

func _ready():
	startingPosition = Vector2(500, 500)
	

func _physics_process(delta):
	var leftPressed =  int(Input.is_action_pressed("left"))
	var rightPressed = int(Input.is_action_pressed("right"))
	var upPressed =    int(Input.is_action_pressed("up"))
	var downPressed =  int(Input.is_action_pressed("down"))
	
	var movementDirection = upPressed*Vector2.UP + downPressed*Vector2.DOWN + leftPressed*Vector2.LEFT + rightPressed*Vector2.RIGHT
	velocity = velocity.lerp(movementDirection.normalized()*maxSpeed, lerpWeight)
	
	
	
	move_and_slide()


func _process(delta):
	toMouse = mousePosition - position
	angleToMouse = toMouse.angle()
	rotation = angleToMouse

func _input(event):
	if event is InputEventMouseMotion:
		mousePosition = event.position
