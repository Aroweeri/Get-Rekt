extends Spatial

var bricks = 0;

func _ready():
	#count bricks in this wall
	bricks = get_children().size();
