extends StaticBody2D

const GLOW = Color(1.4,1.4,1.4)
const WHITE = Color(1,1,1)
const GLOW_DURATOIN = .7

var closed = true

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var glowEffect = $InteractiveGlow
onready var helpText = $HelpText


func _ready():
	set_glow_effect_up()

func _on_InteractionManager_interacted():
	if closed:
		closed = false
		animationPlayer.play("chest_open")
	else:
		closed = true
		animationPlayer.play("chest_close")


func _on_InteractionManager_interaction_object_entered():
	helpText.visible = true
	glowEffect.start()


func _on_InteractionManager_interaction_object_exited():
	helpText.visible = false
	sprite.modulate = WHITE
	glowEffect.stop_all()


func _on_InteractiveGlow_tween_all_completed():
	if sprite.modulate == GLOW:
		set_glow_effect_down()
	else:
		set_glow_effect_up()
	glowEffect.start()


func set_glow_effect_up():
	glowEffect.interpolate_property(
	sprite, 
	'modulate', 
	sprite.modulate, 
	GLOW, 
	GLOW_DURATOIN, 
	Tween.TRANS_SINE, 
	Tween.EASE_IN_OUT)


func set_glow_effect_down():
	glowEffect.interpolate_property(
	sprite, 
	'modulate', 
	sprite.modulate, 
	WHITE, 
	GLOW_DURATOIN, 
	Tween.TRANS_SINE, 
	Tween.EASE_IN_OUT)
