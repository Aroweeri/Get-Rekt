extends Spatial

onready var util = get_node("/root/Util");

var startBricks = 0;
var currentBricks = 0;

var roofFreed;
var score;
var destroyed;
var winscore = 120;

func _ready():
	roofFreed = false;
	score = 0;
	destroyed = false;
	#count bricks that make up this object
	for i in util.findNodeDescendantsInGroup(self, "walls"):
		startBricks += i.bricks;
		print("bricks" + str(i.bricks));
	currentBricks = startBricks;
	
func _process(delta):
	if(not destroyed):
		score = calculate_score();
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
