extends MenuControl

func _on_StartButton_pressed():
	load_main_game_scene()

func _on_QuitButton_pressed():
	get_tree().quit()
