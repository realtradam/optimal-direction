extends Line2D

var skidDraw = true
var wheel
var carBody

func _ready():
	wheel = get_parent().get_parent()
	carBody = get_parent().get_parent().get_parent().get_parent()

func _process(_delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	if(skidDraw):
		add_point(wheel.get_global_position())
