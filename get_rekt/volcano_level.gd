extends Spatial

var score = 0;
var counter;
var time_counter = 0;
var winscore = 210;
var roof1Freed = false;
var roof2Freed = false;
onready var util = get_node("/root/Util");

func _process(delta):

	var scores = 0
	for i in get_tree().get_nodes_in_group("targets"):
		scores += i.score;
		if(!i.roofFreed and i.score > 0):
			i.get_node("roof").queue_free();
			i.roofFreed = true;
	score = scores;

	time_counter += delta;
	if(Input.is_action_just_pressed("quit")):
		get_tree().change_scene("res://main_menu.tscn");

	#reset scores before adding to them again
	for i in get_tree().get_nodes_in_group("targets"):
		i.score = 0;
		
	for i in get_tree().get_nodes_in_group("targets"):
		var walls = util.findNodeDescendantsInGroup(i, "walls");
		var areas = util.findNodeDescendantsInGroup(i, "areas");
		for j in walls:
			for k in j.get_children():
				counter = 0;
				for l in areas:
					if(!l.overlaps_body(k.get_node("RigidBody"))):
						counter+=1;
				if(counter == 1):
					i.score+=1;

	if(score >= winscore && time_counter >= 1):
		$crane.controlsEnabled = false;
		get_node("ui/win_ui").visible = true;
		if(Input.is_action_just_pressed("restart")):
			get_tree().change_scene("res://main_menu.tscn");

	get_node("ui/controls_ui/ScoreHBox/VBoxContainer/score").text = str(score) + "/" + str(winscore);


func _on_in_bounds_area_body_exited(body):
	body.queue_free();
