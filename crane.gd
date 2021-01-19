extends Spatial

var ball_vertical_speed = 0.04;
var controlsEnabled = true;
var time_counter = 0;

func _physics_process(delta):
	time_counter += delta;
	if(time_counter > 2):
		time_counter = 0;
		$ball.apply_impulse(Vector3(0,0,0), Vector3(0,0,0.01));
	handleInput(delta);
			
func _process(delta):
	
	#draw line from chain anchor to ball
	var ballPos = get_node("ball/RopeMountPoint").global_transform.origin;
	var anchorPos = get_node("crane_origin/chain_anchor/ChainMountPoint").global_transform.origin;
	var chain = get_node("chain");
	chain.clear();
	chain.begin(Mesh.PRIMITIVE_LINES);
	chain.add_vertex(ballPos);
	chain.add_vertex(anchorPos);
	chain.end();
	
func handleInput(delta):
	var limit;
	var node;
	
	if(!controlsEnabled):
		return;
	
	if(Input.is_action_pressed("rotate_right")):
		get_node("crane_origin").rotate_y(-0.2*delta);
	elif(Input.is_action_pressed("rotate_left")):
		get_node("crane_origin").rotate_y(0.2*delta)
	if(Input.is_action_pressed("backward")):
		node = get_node("crane_origin/chain_anchor");
		if(node.transform.origin.x > 1.5):
			node.translate(Vector3(-0.05,0,0));
	elif(Input.is_action_pressed("forward")):
		node = get_node("crane_origin/chain_anchor");
		if(node.transform.origin.x < 14.5):
			node.translate(Vector3(0.05,0,0));
	if(Input.is_action_pressed("raise")):
		node = get_node("chain_placeholder/SliderJoint");
		limit = node.get_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER);
		if(limit < 13.9):
			node.set_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER, limit + ball_vertical_speed);
	elif(Input.is_action_pressed("lower")):
		node = get_node("chain_placeholder/SliderJoint");
		limit = node.get_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER);
		if(limit > 0):
			node.set_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER, limit - ball_vertical_speed);
