extends Spatial

onready var util = get_node("/root/Util");

var startBricks = 0;
var currentBricks = 0;

var roofFreed;
var score;
var destroyed;
var winscore = 0;
var hasLaunched = false;

func _ready():
	roofFreed = false;
	score = 0;
	destroyed = false;
	#count bricks that make up this object
	for i in util.findNodeDescendantsInGroup(self, "walls"):
		startBricks += i.bricks;
	currentBricks = startBricks;
	
func _process(delta):
	if(not destroyed):
		score = calculate_score();
	else:
		launch_bricks();
	if(not destroyed and self.score > self.winscore):
		destroyed = true;
		
func calculate_score():
	score = 0;
	var walls = util.findNodeDescendantsInGroup(self, "walls");
	var areas = util.findNodeDescendantsInGroup(self, "areas");
	for i in walls:
		for j in i.get_children():
			for k in areas:
				if(!k.overlaps_body(j.get_node("RigidBody"))):
					score += 1;
	return score;
	
func launch_bricks():
	if(hasLaunched):
		return;
	hasLaunched = true;
	var rng = RandomNumberGenerator.new()
	
	var walls = util.findNodeDescendantsInGroup(self, "walls");
	for i in walls:
		for j in i.get_children():
			#disable collision
			var body = j.get_node("RigidBody");
			body.set_collision_layer_bit(0, false);
			body.set_collision_mask_bit(0, false);
			body.set_collision_layer_bit(2, true);
			body.set_collision_mask_bit(2, true);
			
			body.apply_central_impulse(Vector3(rng.randi_range(-10,10),rng.randi_range(10,20),rng.randi_range(-10,10)));
