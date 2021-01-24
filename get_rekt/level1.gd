extends Spatial

var score;
var time_counter = 0;
var winscore = 120;

func _process(delta):
	time_counter += delta;
	if(Input.is_action_just_pressed("quit")):
		get_tree().quit();
	score = 0;
	for i in $target1.get_node("wall").get_children():
		if(!$target1.get_node("area").overlaps_body(i.get_node("RigidBody"))):
			score+=1;
	for i in $target2.get_node("wall").get_children():
		if(!$target2.get_node("area").overlaps_body(i.get_node("RigidBody"))):
			score+=1;
			
	if(score >= winscore && time_counter >= 1):
		$crane.controlsEnabled = false;
		get_node("Panel2").visible = true;
		if(Input.is_action_just_pressed("restart")):
			get_tree().reload_current_scene();
		
	get_node("Panel/ScoreHBox/VBoxContainer/score").text = str(score) + "/" + str(winscore);


func _on_in_bounds_area_body_exited(body):
	body.queue_free();
