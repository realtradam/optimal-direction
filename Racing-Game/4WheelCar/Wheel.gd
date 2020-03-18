extends RigidBody2D

var velocity #How fast car is moving
var velVector #What direction the car is moving
var velUnitVector #Direction vector, but in a single unit(no magnitude)
var velAngle #The angle of the velocity(relative to world)
var carAngle #The angle to car is facing(relative to world)
var nullStrength #sums up all sources of null to here
var isSkid = false #this one is used when user presses shift. Initially called in this function

#Skidmarks on floor

#var gripDelay = 0

var wheelSlip = Vector2(0,0)

var isForward = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	




func null_slide(var strength, var delta):
	#strength is how strong you would like the nullify to be
	#higher is less sliding/drifting
	var movementUnitVector = get_linear_velocity().normalized()#the direction of the velocity
	var directionAngle = carAngle + (PI/2.0)#the angle the car is facing(relative to the world)
	var directionUnitVector = Vector2(cos(directionAngle),sin(directionAngle)).normalized()#the direction the car is facing
	var nullify = directionUnitVector * movementUnitVector.dot(directionUnitVector)
	wheelSlip = (-(movementUnitVector - nullify))*strength
	apply_central_impulse(wheelSlip*delta*5000)

#checks if the car is braking, and applies brake physics
func setBrake(var strength):
	#Braking
	if Input.is_action_pressed("brake"):
		if velocity > 20:
			linear_damp = 3
		else:
			linear_damp = 6
	else:
		linear_damp = 0.01


func measure_velocity():
		return floor(sqrt(get_linear_velocity().dot(get_linear_velocity()))/12)
