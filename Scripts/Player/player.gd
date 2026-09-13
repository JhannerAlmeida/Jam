extends CharacterBody2D

const WALK_SPEED = 32.0
const RUNNING_SPEED = 64.0
const JUMP_VELOCITY = -256.0
@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("d_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("d_left", "d_right")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	if direction != 0:
		if Input.is_action_pressed("b"):
			velocity.x = direction * RUNNING_SPEED
		else:
			velocity.x = direction * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)

	move_and_slide()
