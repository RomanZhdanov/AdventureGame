extends Control

func _on_TryAgainButton_pressed():
	get_tree().change_scene("res://src/World.tscn")


func _on_ExitButton_pressed():
	get_tree().change_scene("res://src/Screens/StartMenu.tscn")
