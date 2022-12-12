extends MenuControl

func _on_TryAgainButton_pressed():
	load_main_game_scene()

func _on_ExitButton_pressed():
	load_start_menu_scene()
