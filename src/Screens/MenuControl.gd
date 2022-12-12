class_name MenuControl
extends Control

func load_main_game_scene():
	var res = get_tree().change_scene("res://src/Main/Game.tscn")
	handle_scene_change_result(res, "MainGame")

func load_start_menu_scene():
	var res = get_tree().change_scene("res://src/Screens/StartMenu.tscn")
	handle_scene_change_result(res, "StartMenu")

func handle_scene_change_result(result, scene_name):
	if (result == ERR_CANT_OPEN):
		printerr("Can't open the scene '%s', the path is wrong!" % scene_name)
	if (result == ERR_CANT_CREATE):
		printerr("The scene '%s' cannot be instantiated!" % scene_name)
