extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -200.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x == 0:
		$AnimatedSprite.play("default")
	
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false

	move_and_slide()
