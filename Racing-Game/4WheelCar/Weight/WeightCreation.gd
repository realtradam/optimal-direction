extends Node


# This script creates and attaches all "masses". This makes it possible
# to simulate unbalanced weight distribution in a vehicle


# Called when the node enters the scene tree for the first time.
func _ready():
	createWeight(0,30,30)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func createWeight(locX,locY,Mass):
		var weighttemp_resource = load("res://4WheelCar/Weight/Weight.tscn")
		var weighttemp = weighttemp_resource.instance()
		weighttemp.set_position(Vector2(locX,locY))
		add_child(weighttemp)
		weighttemp.initVars(locX,locY,Mass)
