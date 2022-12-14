extends Node2D

const GrassEffect = preload("res://src/Effects/GrassEffect.tscn")
const Berry = preload("res://src/World/Berry.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func create_berry():
	var berry = Berry.instance()
	get_parent().call_deferred("add_child", berry)
	berry.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	if has_berry():
		create_berry()
	queue_free()

func has_berry():
	var probability : int = 10 # 1/10 chance
	if (randi() % probability) == (probability - 1):
		return true
	else:
		return false
