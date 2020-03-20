extends RigidBody2D

var isSkidding = 0
var cameraNode
var speedometerNode

var directionAngle
var directionUnitVector
#curb weight 781kg(body + wheels + engine)
func _ready():
	angular_damp = 5
	mass = 564.8 * 100


	pass

func _process(_delta):
	directionAngle = get_transform().get_rotation() + (PI/2.0)#the angle the car is facing(relative to the world)
	directionUnitVector = Vector2(cos(directionAngle),sin(directionAngle))#the direction the car is facing
	linear_damp = 0.01 #Sets forward momentum dampening

	#HUD Stuff:
	cameraNode = get_node("/root/World/Camera2D")
	speedometerNode = get_node("/root/World/Camera2D/Panel/Speedometer")
	cameraNode.set_position(get_global_transform().get_origin())
	speedometerNode.updateSpeed(floor(measure_velocity()))

	if(Input.is_action_pressed("brake")):
		linear_damp = 2
	else:
		linear_damp = 0.5

#Total speed of the car(in cm per second)
func measure_velocity():
		#dot product of itself gives the magnitude squared
		return sqrt(get_linear_velocity().dot(get_linear_velocity()))*0.036

#Gets only the component that is going in the direction of the car
func measure_forward_velocity():
	return floor(measure_velocity() * cos(directionUnitVector.angle_to(get_linear_velocity())))
