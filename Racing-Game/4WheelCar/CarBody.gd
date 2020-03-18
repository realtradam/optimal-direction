extends RigidBody2D

var isSkidding = 0
var cameraNode
var speedometerNode

var directionAngle
var directionUnitVector

func _ready():
	angular_damp = 5
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

#Total speed of the car
func measure_velocity():
		return sqrt(get_linear_velocity().dot(get_linear_velocity()))/12

#Gets only the component that is going in the direction of the car
func measure_forward_velocity():
	return floor(measure_velocity() * cos(directionUnitVector.angle_to(get_linear_velocity())))
