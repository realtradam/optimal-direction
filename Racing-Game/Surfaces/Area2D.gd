extends Area2D

var err1
var err2

func _ready():
	err1 = connect("body_entered", self, "_on_Area2D_body_enter")
	err2 = connect("body_exited", self, "_on_Area2D_body_exit")

	#stops warning from poping up so yee
	if(err1 != 0 || err2 != 0):
		print(err1)
		print(err2)

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

