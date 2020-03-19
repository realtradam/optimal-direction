extends "res://4WheelCar/Wheel.gd"

#Accelerating
var hp = 4.0
var acceleration = 5

var gripDelay = 0

func _ready():
	pass

func _process(delta):
	#Variable Setup
	#---null_slide vars
	nullStrength = 0
	carAngle = get_node("../../../CarBody").get_transform().get_rotation()
	velVector = get_node("../../../CarBody").get_linear_velocity()
	velocity = measure_velocity()
	#---
	set_rotation(carAngle)

	isSkid = Input.is_action_pressed("grip")
	
	if Input.is_action_pressed("grip") || Input.is_action_pressed("brake"):
		nullStrength += max(5,velocity/7)
	else:
		nullStrength += 1
	
	#Braking
	setBrake(0)
	null_slide(nullStrength, delta)
	
	
	if Input.is_action_pressed("forward"):
		if !Input.is_action_pressed("brake"):
			apply_central_impulse(Vector2(0,-gear(velocity, hp, acceleration)).rotated(carAngle)*delta*5000)
		else:
			pass
	elif Input.is_action_pressed("backward"):
		if !Input.is_action_pressed("brake"):
			apply_central_impulse(Vector2(0,(1)).rotated(carAngle)*delta*5000)
		else:
			pass

func measure_velocity():
	return sqrt(get_linear_velocity().dot(get_linear_velocity()))/12


func gear(var rpm, var maxPower, var topSpeed):
	return max(-pow((rpm/((1000/topSpeed)/sqrt(maxPower)))-sqrt(maxPower),2)+(maxPower+1),0)
