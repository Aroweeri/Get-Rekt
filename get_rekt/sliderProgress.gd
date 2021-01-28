extends ProgressBar

var target;

func _ready():
	target = get_node("../../crane");
	min_value = target.sliderPosMin;
	max_value = target.sliderPosMax;

func _process(_delta):
	value = target.sliderPos;
