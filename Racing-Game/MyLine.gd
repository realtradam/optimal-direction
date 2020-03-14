extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tempnode = 0
var on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
	tempnode = get_node("../Cars/4WheelCar/CarBody/Wheels/BRWheel")
	clear_points()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_BRWheel_slip():
	while on:
		print("slip2")
		add_point(tempnode.get_global_position())
	

func _on_BRWheel_end():
	on = false
	print("duplicated")
	var duplication = duplicate(13)
	duplication.request_ready()
