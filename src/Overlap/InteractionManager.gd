extends Area2D

class_name InteractionManager

var current_interaction

signal interacted
signal interaction_object_entered
signal interaction_object_exited

func initiate_interaction() -> void:
	if current_interaction != null:
		current_interaction.interact()


func interact():
	emit_signal("interacted")


func _on_InteractionManager_area_entered(area):
	current_interaction = area
	emit_signal("interaction_object_entered")


func _on_InteractionManager_area_exited(area):
	if current_interaction == area:
		current_interaction = null
		emit_signal("interaction_object_exited")
