extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
const Berry = preload("res://World/Berry.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func create_berry():
	var berry = Berry.instance()
	get_parent().add_child(berry)
	berry.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	create_berry()
	queue_free()
