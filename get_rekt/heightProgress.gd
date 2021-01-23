extends ProgressBar

var target;

func _ready():
	target = get_node("../../crane");
	min_value = target.ballHeightMin;
	max_value = target.ballHeightMax;

func _process(delta):
	value = target.ballHeight;
