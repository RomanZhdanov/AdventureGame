extends Node2D

const BerryPickupSound = preload("res://src/Pickups/BerryPickupSound.tscn")

var playerStats = PlayerStats

func _on_PickupBox_body_entered(_body):
	if playerStats.health < playerStats.max_health:
		var berryPickupSound = BerryPickupSound.instance()
		get_tree().current_scene.add_child(berryPickupSound)
		playerStats.health += 1
		queue_free()
