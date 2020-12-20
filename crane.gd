extends Spatial

func _physics_process(delta):
	if(Input.is_action_pressed("ui_right")):
		get_node("crane_origin").rotate_y(-0.2*delta);
	elif(Input.is_action_pressed("ui_left")):
		get_node("crane_origin").rotate_y(0.2*delta)
	if(Input.is_action_pressed("ui_down")):
		get_node("crane_origin/chain_anchor").translate(Vector3(-0.05,0,0));
	elif(Input.is_action_pressed("ui_up")):
		get_node("crane_origin/chain_anchor").translate(Vector3(0.05,0,0));
	if(Input.is_action_pressed("ui_page_up")):
		get_node("chain").scale.z -= 0.1;
	elif(Input.is_action_pressed("ui_page_down")):
		get_node("chain").scale.z += 0.1;
