extends Position2D

signal Interact()


func _on_Area2D_body_entered(body):
	print(body.name)


func _on_Area2D_body_exited(body):
	pass # Replace with function body.
