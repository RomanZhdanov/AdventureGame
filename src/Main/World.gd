extends Node2D



func _on_Player_died():
	var res = get_tree().change_scene("res://src/Screens/GameOver.tscn")
	if (res == ERR_CANT_OPEN):
		printerr("Can't open the GameOver scene, the path is wrong!")
	if (res == ERR_CANT_CREATE):
		printerr("The GameOver scene cannot be instantiated!")
