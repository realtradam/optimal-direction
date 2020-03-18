extends "res://4WheelCar/Wheel.gd"

#Reduces steering strength when braking
var steerDamp = 1

#Steering Curve Vars
var steerSplitA = 20
var steerSplitB = 40
var steerHeight = 2.6
var steerLimit = 73
var steerMinimum = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Variable Update
	#---null_slide vars
	nullStrength = 0
	velocity = measure_velocity()
	velVector = get_node("../../../CarBody").get_linear_velocity()
	carAngle = get_node("../../../CarBody").get_transform().get_rotation()
	#---Steering Vars
	velAngle = atan2(velVector.y,velVector.x)
	isForward = is_forward()
	#---
	set_rotation(carAngle)
	
	isSkid = Input.is_action_pressed("grip")
	
	#Determines if drifting
	if Input.is_action_pressed("grip") || Input.is_action_pressed("brake"):
		nullStrength += max(5,velocity/7)
	else:
		nullStrength += 1
	
	#Braking
	setBrake(0)
	null_slide(nullStrength,delta)
	
	#Steering
	if Input.is_action_pressed("steer_left"):
		apply_central_impulse(steerDamp*Vector2(0,steer_curve(steerSplitA, steerSplitB, steerHeight, steerLimit,steerMinimum)).rotated(steer_angle())*delta*5000)
	if Input.is_action_pressed("steer_right"):
		apply_central_impulse(steerDamp*Vector2(0,-steer_curve(steerSplitA, steerSplitB, steerHeight, steerLimit,steerMinimum)).rotated(steer_angle())*delta*5000)

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

func is_forward():
	var carVector = Vector2(cos(carAngle + PI/2),sin(carAngle + PI/2))
	if velVector == Vector2(0,0) || carVector == Vector2(0,0):
		return true
	if velVector.dot(carVector) <= 0:
		return true
	else:
		return false
