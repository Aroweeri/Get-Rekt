extends Spatial

var score;

func _process(delta):
	score = 0;
	for i in $target1.get_node("wall").get_children():
		if(!$target1.get_node("area").overlaps_body(i.get_node("RigidBody"))):
			score+=1;
	for i in $target2.get_node("wall").get_children():
		if(!$target2.get_node("area").overlaps_body(i.get_node("RigidBody"))):
			score+=1;
	$score.text = str(score);
