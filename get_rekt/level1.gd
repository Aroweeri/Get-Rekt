extends Spatial

var score = 0;
var counter;
var time_counter = 0;
var winscore = 140;
var roofFreed = false;

func _process(delta):
	if(!roofFreed and score > 0):
		get_node("target1/roof").queue_free();
		roofFreed = true;
	time_counter += delta;
	if(Input.is_action_just_pressed("quit")):
		get_tree().quit();
	score = 0;
	for i in get_tree().get_nodes_in_group("walls"):
		for j in i.get_children():
			counter = 0;
			for k in get_tree().get_nodes_in_group("areas"):
				if(!k.overlaps_body(j.get_node("RigidBody"))):
					counter+=1;
			if(counter == 4):
				score+=1;
				
	if(score >= winscore && time_counter >= 1):
		$crane.controlsEnabled = false;
		get_node("Panel2").visible = true;
		if(Input.is_action_just_pressed("restart")):
			get_tree().reload_current_scene();
		
	get_node("Panel/ScoreHBox/VBoxContainer/score").text = str(score) + "/" + str(winscore);


func _on_in_bounds_area_body_exited(body):
	body.queue_free();
