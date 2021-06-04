extends Spatial

func _ready():
	for i in get_tree().get_nodes_in_group("targets"):
		i.winscore = 130;
	get_node("music").play();

func _process(delta):
	var scores = 0
	var numDestroyed = 0;
	var numTargets = 0;
	for i in get_tree().get_nodes_in_group("targets"):
		scores += i.score;
		if(!i.roofFreed and i.score > 0):
			i.get_node("roof").queue_free();
			i.roofFreed = true;

	if(Input.is_action_just_pressed("quit")):
		get_tree().change_scene("res://main_menu.tscn");

	#check if all targets are destroyed
	for i in get_tree().get_nodes_in_group("targets"):
		numTargets += 1;
	for i in get_tree().get_nodes_in_group("targets"):
		if(i.destroyed):
			numDestroyed += 1;

	if(numDestroyed == numTargets):
		$crane.controlsEnabled = false;
		get_node("ui/win_ui").visible = true;
		if(Input.is_action_just_pressed("restart")):
			get_tree().change_scene("res://main_menu.tscn");

	get_node("ui/controls_ui/ScoreHBox/VBoxContainer/score").text = "Destroyed: " + str(numDestroyed) + "/" + str(numTargets);

func _on_in_bounds_area_body_exited(body):
	body.queue_free();
