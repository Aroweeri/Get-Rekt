extends ProgressBar

var target;

func _ready():
	target = get_node("../../crane");
	min_value = target.craneRotationMin + 90;
	max_value = target.craneRotationMax + 90;

func _process(delta):
	value = target.craneRotation
