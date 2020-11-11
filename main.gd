extends Spatial

func _physics_process(delta):
	if(Input.is_action_pressed("ui_right")):
		get_node("crane_origin").rotate_y(-0.2*delta);
	elif(Input.is_action_pressed("ui_left")):
		get_node("crane_origin").rotate_y(0.2*delta)
