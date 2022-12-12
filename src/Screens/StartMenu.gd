extends Control

func _on_StartButton_pressed():
	var res = get_tree().change_scene("res://src/Main/Game.tscn")
	if (res == ERR_CANT_OPEN):
		printerr("Can't open the Game scene, the path is wrong!")
	if (res == ERR_CANT_CREATE):
		printerr("The Game scene cannot be instantiated!")


func _on_QuitButton_pressed():
	get_tree().quit()
