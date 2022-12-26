extends Area2D

class_name InteractionManager

var current_interaction

signal interacted

func initiate_interaction() -> void:
	if current_interaction != null:
		current_interaction.interact()


func interact():
	emit_signal("interacted")


func _on_InteractionManager_area_entered(area):
	current_interaction = area


func _on_InteractionManager_area_exited(area):
	if current_interaction == area:
		current_interaction = null
