extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func initVars(locX,locY,Mass):
#	#---Creating and attaching pinjoint to wheel
	mass = Mass
	var tempA = PinJoint2D.new()
	tempA.set_position(Vector2(locX,locY))
	print(get_parent().get_parent().get_path())
	tempA.set_node_a(get_path())
	tempA.set_node_b(get_parent().get_parent().get_path())
	tempA.softness = 0
	tempA.bias = 0
	tempA.disable_collision = true
	get_parent().add_child(tempA)
#	#---
	pass
