extends Spatial

var score;

func _process(delta):
	score = 0;
	for i in $target1.get_children():
		if(!$target1area.overlaps_body(i.get_node("RigidBody"))):
			score+=1;
	$score.text = str(score);
