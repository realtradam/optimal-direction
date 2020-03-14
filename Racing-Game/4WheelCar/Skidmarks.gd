extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skidDraw = true
var wheel
var carBody

# Called when the node enters the scene tree for the first time.
func _ready():
	wheel = get_parent().get_parent()
	carBody = get_parent().get_parent().get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	if(skidDraw):
		add_point(wheel.get_global_position())
