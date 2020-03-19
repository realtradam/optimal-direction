extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	createWheel("front", [17,-27])
	createWheel("front", [-17,-27])
	createWheel("back", [20,36])
	createWheel("back", [-20,36])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func createWheel(type,dataArray):
	if(type == "front"):
		var wheeltemp_resource = load("res://4WheelCar/FrontWheel.tscn")
		var wheeltemp = wheeltemp_resource.instance()
		wheeltemp.set_position(Vector2(dataArray[0],dataArray[1]))
		add_child(wheeltemp)
		wheeltemp.initVars(dataArray)
		
#		add_child(tempA)
	elif(type == "back"):
		var wheeltemp_resource = load("res://4WheelCar/BackWheel.tscn")
		var wheeltemp = wheeltemp_resource.instance()
		wheeltemp.set_position(Vector2(dataArray[0],dataArray[1]))
		add_child(wheeltemp)
		wheeltemp.initVars(dataArray)
