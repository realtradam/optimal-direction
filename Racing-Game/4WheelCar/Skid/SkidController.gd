extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skidSwitch = false # Is the wheel currantly skidding?
var skidFile # Stores the skid file
var skidRecent # Holds the most recent skidmark

var deleteme = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	skidFile = load("res://4WheelCar/Skid/Skidmark.tscn")
	skidRecent = skidFile.instance()
	add_child(skidRecent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if(skidSwitch && get_parent().isSkid):#if controller believes car is skidding and the wheel is skidding
		#ignore the status and let the skid keep drawing
		pass
	elif(!skidSwitch && get_parent().isSkid):#controller doesnt skid, but wheel is supposed to be skidding
		# create new skidding child, and set skid to true

		skidSwitch = true
		skidFile = load("res://4WheelCar/Skid/Skidmark.tscn")
		skidRecent = skidFile.instance()
		add_child(skidRecent)
		#set to run
		pass
	elif(!get_parent().isSkid):
		#stop child from skidding and store
		skidRecent.skidDraw = false
		skidSwitch = false
		pass
	
