extends Spatial

var ball_vertical_speed = 0.04;
var controlsEnabled = true;
var time_counter = 0;
var ballHeight = 0;
var ballHeightMin = 0;
var ballHeightMax = 12;
var sliderPos = 14;
var sliderPosMin = 1.5;
var sliderPosMax = 14.5;
var craneRotation = 0;
var craneRotationSpeed = 0;
var craneRotationSpeedMax = 0.1;

func _physics_process(delta):
	time_counter += delta;
	if(time_counter > 2):
		time_counter = 0;
		$ball.apply_impulse(Vector3(0,0,0), Vector3(0,0,0.01));
	handleInput(delta);
	
	craneRotationSpeed *= 0.95;
	craneRotation = craneRotation + craneRotationSpeed;


			
func _process(delta):
	
	get_node("crane_origin").rotation.y = craneRotation;
	get_node("crane_origin/chain_anchor").transform.origin.x = sliderPos;
	get_node("chain_placeholder/SliderJoint").set_param(SliderJoint.PARAM_LINEAR_LIMIT_LOWER, ballHeight);

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
	var node;
	
	if(!controlsEnabled):
		return;
	
	#adjust crane values
	if(Input.is_action_pressed("rotate_right")):
		craneRotationSpeed -= 0.02*delta;
		if(craneRotationSpeed < 0-craneRotationSpeedMax):
			craneRotationSpeed = 0-craneRotationSpeedMax;
	elif(Input.is_action_pressed("rotate_left")):
		craneRotationSpeed += 0.02*delta;
		if(craneRotationSpeed > craneRotationSpeedMax):
			craneRotationSpeed = craneRotationSpeedMax;


	if(Input.is_action_pressed("backward")):
		sliderPos -= 0.05;
	elif(Input.is_action_pressed("forward")):
		sliderPos += 0.05
	if(Input.is_action_pressed("raise")):
		ballHeight += ball_vertical_speed;
	elif(Input.is_action_pressed("lower")):
		ballHeight -= ball_vertical_speed;
		
	#correct for values past min/max
	if(sliderPos > sliderPosMax):
		sliderPos = sliderPosMax;
	if(sliderPos < sliderPosMin):
		sliderPos = sliderPosMin;
	if(ballHeight > ballHeightMax):
		ballHeight = ballHeightMax;
	if(ballHeight < ballHeightMin):
		ballHeight = ballHeightMin;
