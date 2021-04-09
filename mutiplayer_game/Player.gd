extends KinematicBody

var speed = 15

var direction = Vector3()

remote func _set_position(pos):
	global_transform.origin = pos

func _physics_process(delta: float) -> void:
	direction = Vector3()
	
	if Input.is_action_pressed("move_left"):
		direction += transform.basis.z
		
	elif Input.is_action_pressed("move_right"):
		direction -= transform.basis.z
		
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.x
		
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.x
		
	if direction != Vector3():
		if is_network_master():
			move_and_slide(direction * speed, Vector3.UP)
		rpc_unreliable("_set_position", global_transform.origin)
