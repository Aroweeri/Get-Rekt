extends Spatial

var ball_vertical_speed = 0.04;

func _physics_process(delta):
	var limit;
	var node;
	if(Input.is_action_pressed("ui_right")):
		get_node("crane_origin").rotate_y(-0.2*delta);
	elif(Input.is_action_pressed("ui_left")):
		get_node("crane_origin").rotate_y(0.2*delta)
	if(Input.is_action_pressed("ui_down")):
		node = get_node("crane_origin/chain_anchor");
		if(node.transform.origin.x > 2):
			node.translate(Vector3(-0.05,0,0));
	elif(Input.is_action_pressed("ui_up")):
		node = get_node("crane_origin/chain_anchor");
		if(node.transform.origin.x < 12):
			node.translate(Vector3(0.05,0,0));
	if(Input.is_action_pressed("ui_page_up")):
		node = get_node("chain_placeholder/SliderJoint");
		limit = node.get_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER);
		if(limit < 8.9):
			node.set_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER, limit + ball_vertical_speed);
	elif(Input.is_action_pressed("ui_page_down")):
		node = get_node("chain_placeholder/SliderJoint");
		limit = node.get_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER);
		if(limit > -1):
			node.set_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER, limit - ball_vertical_speed);
