extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	set_rotation(0)
	pass

func displaySpeed(var velocity):
	print(velocity)


func updateSpeed(var velocity):
	text = str(velocity)
