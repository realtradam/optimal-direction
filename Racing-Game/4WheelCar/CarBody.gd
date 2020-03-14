extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
var angular = 0;
var directionAngle
var directionUnitVector
var cameraNode
var speedometerNode
var isSkidding = 0
var frWheel
var flWheel
var brWheel
var blWheel

func _ready():
		frWheel = get_node("./Engine/Wheels/FRWheel")
		flWheel = get_node("./Engine/Wheels/FLWheel")
		brWheel = get_node("./Engine/Wheels/BRWheel")
		blWheel = get_node("./Engine/Wheels/BLWheel")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	directionAngle = get_transform().get_rotation() + (PI/2.0)#the angle the car is facing(relative to the world)
	directionUnitVector = Vector2(cos(directionAngle),sin(directionAngle))#the direction the car is facing
	linear_damp = 0.01
	angular = 5
	
	if(isSkidding > 0):
		frWheel.isSkidOverride = true
		flWheel.isSkidOverride = true
		brWheel.isSkidOverride = true
		blWheel.isSkidOverride = true
		frWheel.isSkid = true
		flWheel.isSkid = true
		brWheel.isSkid = true
		blWheel.isSkid = true
	#emit_signal("speedometer", measure_forward_velocity())
	cameraNode = get_node("/root/World/Camera2D")
	speedometerNode = get_node("/root/World/Camera2D/Panel/Speedometer")
	cameraNode.set_position(get_global_transform().get_origin())
	speedometerNode.updateSpeed(floor(measure_velocity()))
	
	if measure_velocity() < 30:
		angular_damp = angular*1
	elif measure_velocity() < 85:
		angular_damp = angular*0.4
	else:
		angular_damp = angular*0.05


	
func measure_velocity():
		return sqrt(get_linear_velocity().dot(get_linear_velocity()))/12

func measure_forward_velocity():
	return floor(measure_velocity() * cos(directionUnitVector.angle_to(get_linear_velocity())))
	
func forceSkidMarks(skid):
	isSkidding += skid
