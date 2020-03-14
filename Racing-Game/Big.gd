extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):
	var maxspeed = 108
	var speed = 8.4
	var steer = 350
	set_angular_damp(1)
	if Input.is_key_pressed(KEY_W) && !Input.is_key_pressed(KEY_SPACE):
		apply_central_impulse(Vector2(speed,0).rotated(get_transform().get_rotation()))
	if Input.is_key_pressed(KEY_S):
		apply_central_impulse(Vector2(-(speed*0.2),0).rotated(get_transform().get_rotation()))
	if Input.is_key_pressed(KEY_ALT):
		#brakes here
		linear_damp = 5
	else:
		linear_damp = 0.5
	if Input.is_key_pressed(KEY_SPACE):
		null_slide(80)
	else:
		null_slide(15)

func null_slide(var tire_slip):
	var movement_vector = get_linear_velocity()
	var sidewaysAngle = get_transform().get_rotation()
	var sidewaysAxis = Vector2(cos(sidewaysAngle),sin(sidewaysAngle))
	var nullify = sidewaysAxis * movement_vector.dot(sidewaysAxis)
	apply_central_impulse(-(movement_vector - nullify)/(float(tire_slip)))
