extends Control

func _on_TryAgainButton_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_ExitButton_pressed():
	get_tree().change_scene("res://Screens/StartMenu.tscn")
