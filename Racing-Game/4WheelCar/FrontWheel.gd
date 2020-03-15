extends RigidBody2D

var velocity #How fast car is moving
var velVector #What direction the car is moving
var velUnitVector #Direction vector, but in a single unit(no magnitude)
var velAngle #The angle of the velocity(relative to world)
var carAngle #The angle to car is facing(relative to world)

#Skidmarks on floor
onready var skidObj = preload("res://4WheelCar/Skid/Skidmark.tscn")

#Reduces steering strength when braking
var steerDampBase = 1
var steerDamp = 1

#Steering Curve Vars
var steerSplitA = 20
var steerSplitB = 40
var steerHeight = 2.6
var steerLimit = 73
var steerMinimum = 1

var gripDelay = 0

var wheelSlip = Vector2(0,0)
var isSkid = false #this one is used when user presses shift. Initially called in this function
var isSkidOverride = false #this one is used when driving over sand, initially called in carbody

signal slip
signal end
var elapsed = 0

var isForward = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Variable Setup
	#---
	velocity = measure_velocity()
	velVector = get_node("../../../CarBody").get_linear_velocity()
	velUnitVector = velVector.normalized()
	velAngle = atan2(velVector.y,velVector.x)
	carAngle = get_node("../../../CarBody").get_transform().get_rotation()
	isForward = is_forward()
	#---
	set_rotation(carAngle)
#	gripDelay = has_grip(0.4,delta)
	isSlip(delta)
	
	if(!isSkidOverride):
		isSkid = Input.is_action_pressed("grip")
	
	#Determines if drifting
	if Input.is_action_pressed("grip") || Input.is_action_pressed("brake"):
		null_slide(max(5,velocity/7),delta)
	else:
		null_slide(1,delta)
	
	#Braking
	if Input.is_action_pressed("brake"):
		if velocity > 20:
			linear_damp = 3
			steerDamp = 0.7
		else:
			linear_damp = 6
			steerDamp = 0.4
	else:
		linear_damp = 0.01
		steerDamp = 1
	
	#Steering
	if Input.is_action_pressed("steer_left"):
		apply_central_impulse(steerDamp*Vector2(0,steer_curve(steerSplitA, steerSplitB, steerHeight, steerLimit,steerMinimum)).rotated(steer_angle())*delta*5000)
	if Input.is_action_pressed("steer_right"):
		apply_central_impulse(steerDamp*Vector2(0,-steer_curve(steerSplitA, steerSplitB, steerHeight, steerLimit,steerMinimum)).rotated(steer_angle())*delta*5000)




func null_slide(var strength, var delta):
	#strength is how strong you would like the nullify to be
	#higher is less sliding/drifting
	var movementUnitVector = get_linear_velocity().normalized()#the direction of the velocity
	var directionAngle = carAngle + (PI/2.0)#the angle the car is facing(relative to the world)
	var directionUnitVector = Vector2(cos(directionAngle),sin(directionAngle)).normalized()#the direction the car is facing
	var nullify = directionUnitVector * movementUnitVector.dot(directionUnitVector)
	wheelSlip = (-(movementUnitVector - nullify))*strength
	apply_central_impulse(wheelSlip*delta*5000)

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

#Determines if skidmarks should be creted, or stopped
func isSlip(time):
	if (wheelSlip.length() > 0.6):
		if(elapsed/4 > time):
			emit_signal("end")
			elapsed = 0
		else:
			emit_signal("slip")
	else:
		elapsed += time

func measure_velocity():
		return floor(sqrt(get_linear_velocity().dot(get_linear_velocity()))/12)

#determines if the car is driving forward, or backward
func is_forward():
	var carVector = Vector2(cos(carAngle + PI/2),sin(carAngle + PI/2))
	if velVector == Vector2(0,0) || carVector == Vector2(0,0):
		return true
	if velVector.dot(carVector) <= 0:
		return true
	else:
		return false

#returns the angle the car is facing, relative to the direction it is moving
func steer_angle():
	if isForward:
		return carAngle + (PI/2.0)
	else:
		return carAngle - (PI/2.0)

#Determines strength of steering as a function of the speed
func steer_curve(var splitA, splitB, var height, var limit, var minimum):
	#Rules: 
	# splitA < splitB < limit
	# height > 0, limit >= 0
	# ---
	#Desmos: SteerCurve
	#Link: https://www.desmos.com/calculator/jkrd8zzoj9
	# splitA = a
	# splitB = b
	# height = h
	# limit = f
	#note: minimum is not in the graph, it is simply the minimum y value you want when x > splitB
	# ---
	if(velocity >= splitB):
		return max((-pow((velocity-splitB)/((limit-splitB)/sqrt(height)),2)+height)*abs(cos(abs(velAngle-carAngle)+PI/2)),minimum)
	elif velocity >= splitA:
		return height
	else:
		return max((-pow((velocity/(splitA/sqrt(height)))-sqrt(height),2)+height)*abs(cos(abs(velAngle-carAngle)+PI/2)),0)
