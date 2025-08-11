extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var attacking = false

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()
func attack():
	attacking = true
	animated_sprite.play("Attack1")
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flips the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		# Applys movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Play animations.
func update_animation():
	if !attacking:
		if velocity.x != 0:
			animated_sprite.play("Run")
		else:
			animated_sprite.play("Idle")
		
		if velocity.y < 0:
			animated_sprite.play("Jump")
		if velocity.y > 0:
			animated_sprite.play("Fall")


	move_and_slide()
