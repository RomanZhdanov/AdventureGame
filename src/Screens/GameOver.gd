extends Control

func _on_TryAgainButton_pressed():
	get_tree().change_scene("res://src/Main/Game.tscn")


func _on_ExitButton_pressed():
	get_tree().change_scene("res://src/Screens/StartMenu.tscn")
