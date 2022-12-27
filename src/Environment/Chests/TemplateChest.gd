extends StaticBody2D

var closed = true

onready var animationPlayer = $AnimationPlayer

func _on_InteractionManager_interacted():
	if closed:
		closed = false
		animationPlayer.play("chest_open")
	else:
		closed = true
		animationPlayer.play("chest_close")
