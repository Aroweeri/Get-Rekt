extends ProgressBar

var target;

func _ready():
	target = get_node("../../crane");
	min_value = target.ballHeightMin;
	max_value = target.ballHeightMax;

func _process(_delta):
	value = target.ballHeight;
