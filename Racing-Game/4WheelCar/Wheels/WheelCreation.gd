extends Node


# This script creates and attaches all the wheels. Depending on the variables
# given to this script, it can generate different type of vehicles


# Called when the node enters the scene tree for the first time.
func _ready():
	createWheel(17,-27,"front")
	createWheel(-17,-27,"front")
	createWheel(20,36,"back")
	createWheel(-20,36,"back")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func createWheel(locX, locY, type):
	if(type == "front"):
		var wheeltemp_resource = load("res://4WheelCar/Wheels/FrontWheel.tscn")
		var wheeltemp = wheeltemp_resource.instance()
		wheeltemp.set_position(Vector2(locX,locY))
		add_child(wheeltemp)
		wheeltemp.initVars(locX,locY)

#		add_child(tempA)
	elif(type == "back"):
		var wheeltemp_resource = load("res://4WheelCar/Wheels/BackWheel.tscn")
		var wheeltemp = wheeltemp_resource.instance()
		wheeltemp.set_position(Vector2(locX,locY))
		add_child(wheeltemp)
		wheeltemp.initVars(locX,locY)
