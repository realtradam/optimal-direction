extends RemoteTransform2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = get_node("/root/World/Camera2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#camera.global_position = global_position
	#camera.global_rotation = global_rotation;
	pass
