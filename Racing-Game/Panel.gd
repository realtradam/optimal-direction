extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var window_rect = OS.get_window_size()
	
	set_position(Vector2(window_rect.x - 500, window_rect.y - 330))
	pass
