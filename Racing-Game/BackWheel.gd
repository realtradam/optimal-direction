extends RigidBody2D

#Accelerating
var hp = 4.0
var acceleration = 5
var isForward = true

var velocity

var lastLoc = 0;

var wheelSlip = Vector2(0,0);
var isSkid = false;

signal slip
signal end
var elapsed = 0
#
var gripDelay = 0
var carAngle
var carVector
var velVector

# Called when the node enters the scene tree for the first time.
func _ready():
	lastLoc = get_position_in_parent()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	carAngle = get_node("../../../CarBody").get_transform().get_rotation()
	carVector = Vector2(cos(carAngle + PI/2),sin(carAngle + PI/2))
	velVector = get_node("../../../CarBody").get_linear_velocity()
	velocity = measure_velocity()
	isForward = is_forward()
	set_rotation(carAngle)
	isSlip(delta)
	
#	gripDelay = has_grip(0.4,delta)

	isSkid = Input.is_action_pressed("grip")
	
	if Input.is_action_pressed("grip") || Input.is_action_pressed("break"):
		null_slide(max(5,velocity/7),delta)
	else:
		null_slide(1,delta)	
	#Braking
	if Input.is_action_pressed("break"):
		if velocity > 20:
			linear_damp = 2
		else:
			linear_damp = 5
	else:
		linear_damp = 0.01
	
#	createLine(lastLoc, get_position_in_parent())
#	lastLoc = get_position_in_parent()
	
	if Input.is_action_pressed("forward"):
		if !Input.is_action_pressed("break"):
			apply_central_impulse(Vector2(0,-gear(velocity, hp, acceleration)).rotated(carAngle)*delta*5000)
		else:
			pass
	elif Input.is_action_pressed("backward"):
		if !Input.is_action_pressed("break"):
			apply_central_impulse(Vector2(0,(1)).rotated(carAngle)*delta*5000)
		else:
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
	
func isSlip(time):
	if (wheelSlip.length() > 0.2):
		emit_signal("slip")
	else:
		emit_signal("end")

#func createLine(from, to):
#	var tires = get_node("./MyLine")
#	tires.add_point(from)
#	tires.add_point(to)
	
#func has_grip(var tractionDelay, var delta):
#	var movementUnitVector = get_linear_velocity().normalized()#the direction of the velocity
#	var directionAngle = carAngle#the angle the car is facing(relative to the world)
#	var directionUnitVector = Vector2(cos(directionAngle),sin(directionAngle)).normalized()#the direction the car is facing
#	if velocity > 10:
#		if Input.is_action_pressed("grip"):##if pressing shift
#			gripDelay = tractionDelay
#		elif (gripDelay <= 0 && abs(movementUnitVector.dot(directionUnitVector)) > 0.4):#if not drifting but past steering point
#			gripDelay = tractionDelay
#		elif gripDelay > 0 && abs(movementUnitVector.dot(directionUnitVector)) > 0.3:#if drifting and past steering point
#			gripDelay = tractionDelay
#		elif gripDelay > 0:#if at recovery point and drifting
#			gripDelay -= delta
#	else:
#		gripDelay = 0
#	return gripDelay

func measure_velocity():
	return sqrt(get_linear_velocity().dot(get_linear_velocity()))/12

func is_forward():#determines if the car is driving forward, or backward
	var carVector = Vector2(cos(carAngle + PI/2),sin(carAngle + PI/2))
	if velVector == Vector2(0,0) || carVector == Vector2(0,0):
		return true
	if velVector.dot(carVector) <= 0:
		return true
	else:
		return false

func gear(var rpm, var maxPower, var topSpeed):
	return max(-pow((rpm/((1000/topSpeed)/sqrt(maxPower)))-sqrt(maxPower),2)+(maxPower+1),0)
