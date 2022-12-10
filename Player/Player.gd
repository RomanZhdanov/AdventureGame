extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var FRICTION = 500
export(float) var STAMINA_RATE = 1

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats
var stamina_timeout = 0

signal died

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	randomize()
	stats.set_health(stats.max_health)
	stats.connect("no_health", self, "death")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		ROLL:
			roll_state()
		
		ATTACK:
			attack_state()
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	stamina_timeout += delta
	
	if stamina_timeout >= STAMINA_RATE:
		stats.stamina += 1
		stamina_timeout = 0
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
	if Input.is_action_just_pressed("roll"):
		state = ROLL

func attack_state():
	if stats.stamina > 0:
		velocity = Vector2.ZERO
		animationState.travel("Attack")
	else:
		state = MOVE

func roll_state():
	if stats.stamina > 0:
		velocity = roll_vector * ROLL_SPEED
		animationState.travel("Roll")
		move()
	else:
		state = MOVE

func move():
	velocity = move_and_slide(velocity)

func attack_animation_finished():
	stats.stamina -= 1
	state = MOVE

func roll_animation_finished():
	velocity = velocity * 0.8
	stats.stamina -= 1
	state = MOVE

func _on_Hurtbox_area_entered(area):
	if hurtbox.invincible == false:
		stats.health -= area.damage
		hurtbox.start_invincibility(1.0)
		hurtbox.create_hit_effect();
		var plyerHurtSound = PlayerHurtSound.instance()
		get_tree().current_scene.add_child(plyerHurtSound)

func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")


func death():
	queue_free()
	emit_signal("died")