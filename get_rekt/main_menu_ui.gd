extends Control


func _on_island_load_button_pressed():
	get_tree().change_scene("res://island_level.tscn");


func _on_volcano_load_button_pressed():
	get_tree().change_scene("res://volcano_level.tscn")


func _on_quit_button_pressed():
	get_tree().quit();


func _on_snow_load_button_pressed():
	get_tree().change_scene("res://snow_level.tscn")
