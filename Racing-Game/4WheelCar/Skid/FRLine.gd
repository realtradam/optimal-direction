extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tempnode = 0
var on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	tempnode = get_node("../Cars/4WheelCar/CarBody/Wheels/FRWheel")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_FRWheel_slip():
	if(on):
		add_point(tempnode.get_global_position())


func _on_FRWheel_end():
	duplicate(1)
	on = false
