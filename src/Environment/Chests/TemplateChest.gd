extends StaticBody2D

const GLOW = Color(1.4,1.4,1.4)
const WHITE = Color(1,1,1)
const GLOW_DURATOIN = .7

var lid_is_closed = true

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var glowEffect = $InteractiveGlow
onready var interactionTip = $InteractionTip


func _ready():
	show_interaction_tip(false)
	set_glow_effect_up()

func _on_InteractionManager_interacted():
	if lid_is_closed:
		lid_is_closed = false
		animationPlayer.play("chest_open")
	else:
		lid_is_closed = true
		animationPlayer.play("chest_close")


func _on_InteractionManager_interaction_object_entered():
	show_interaction_tip(true)
	glowEffect.start()


func _on_InteractionManager_interaction_object_exited():
	show_interaction_tip(false)
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


func show_interaction_tip(show: bool):
	set_interaction_tip_text()
	interactionTip.visible = show

func set_interaction_tip_text():
	var tip = interactionTip.get_node("TipText")
	if lid_is_closed:
		tip.text = "Open"
	else:
		tip.text = "Close"


func _on_AnimationPlayer_animation_finished(_anim_name):
	set_interaction_tip_text()
