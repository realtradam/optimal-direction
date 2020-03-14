extends RigidBody2D
var delay = 0;
func _process(delta):
	var steer = 5
	null_slide(15)
#	measure_velocity()
#	set_angular_damp(1)
#	if Input.is_key_pressed(KEY_D):
#		apply_torque_impulse(steer)
#		apply_central_impulse(Vector2(0,steer).rotated(get_transform().get_rotation()))
#	if Input.is_key_pressed(KEY_A):
#		apply_central_impulse(Vector2(0,-steer).rotated(get_transform().get_rotation()))



#	if Input.is_key_pressed(KEY_SPACE):
#		null_slide(80)
#	else:
#		null_slide(15)		
func measure_velocity():
	if delay <= 0:
		print(sqrt(get_linear_velocity().dot(get_linear_velocity()))/12)
		delay = 600
	else:
		delay -= 1

func null_slide(var tire_slip):
	var movement_vector = get_linear_velocity()
	var sidewaysAngle = get_transform().get_rotation()
	var sidewaysAxis = Vector2(cos(sidewaysAngle),sin(sidewaysAngle))
	var nullify = sidewaysAxis * movement_vector.dot(sidewaysAxis)
	apply_central_impulse(-(movement_vector - nullify)/(float(tire_slip)))
