extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Area2D_body_enter")
	connect("body_exited", self, "_on_Area2D_body_exit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_enter(body):
	print(body.get_name(), " entered area")
	if(body.has_method("forceSkidmarks")):
		body.forceSkidmarks(1)
	#print(str('Body entered: ', body.get_name()))

func _on_Area2D_body_exit(body):
	print(body.get_name(), " exited area")
	if(body.has_method("forceSkidmarks")):
		body.forceSkidmarks(1)

