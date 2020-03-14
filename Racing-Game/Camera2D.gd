extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var printfps = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	zoom = Vector2(2,2)
	connect("pos",get_node("Cars/4WheelCar"),"_on_CarBody_pos")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	#print fps
#	printfps += delta
#	if(printfps > 1):
#		print(1/delta)
#		printfps -= 1
	pass
	
func set_position(pos):
	position = pos;


func _on_CarBody_pos(pos):
	#velocity = velocity/100 + 1.5
	#zoom = Vector2(velocity,velocity)
	position = pos
