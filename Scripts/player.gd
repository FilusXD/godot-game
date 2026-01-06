extends CharacterBody2D
class_name PlayerController

const SPEED = 230.0
const JUMP_VELOCITY = -300.0
const ATTACK_DURATION = 0.4 # délka animace v sekundách
const FALL_THROUGH_TIME = 0.3 # jak dlouho bude vypnutá kolize

var is_attacking = false
var attack_timer = 0.0
var is_falling_through = false
var last_floor_collider = null

func _physics_process(delta: float) -> void:
	# gravitace
	if !is_on_floor():
		velocity += get_gravity() * delta

	# skok
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_attacking:
		velocity.y = JUMP_VELOCITY

	# útok
	if Input.is_action_just_pressed("strike") and not is_attacking:
		is_attacking = true
		attack_timer = ATTACK_DURATION
		$PlayerAnimation.play("strike")

	# odpočítávání útoku
	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false


	# pohyb jen pokud neútočí
	var direction := 0.0
	if not is_attacking:
		direction = Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_attacking:
		handleAnimations(direction)

	move_and_slide()

	# restart pokud spadne z mapy
	if velocity.y > 2000:
		get_tree().change_scene_to_file("res://world.tscn")


func handleAnimations(direction):
	if direction == -1:
		$PlayerAnimation.flip_h = true
	elif direction == 1:
		$PlayerAnimation.flip_h = false

	if not is_on_floor():
		$PlayerAnimation.play("jump")
	elif direction != 0:
		$PlayerAnimation.play("run")
	else:
		$PlayerAnimation.play("idle")
