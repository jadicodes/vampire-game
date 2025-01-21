extends CharacterBody2D


const SPEED = 60.0
const SPRINT_SPEED = 110.0
const JUMP_VELOCITY = -200.0

var is_within_bite_distance


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		$AnimatedSprite.play("walk")
		if Input.is_action_pressed("sprint"):
			velocity.x = direction * SPRINT_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x == 0:
		$AnimatedSprite.play("default")
	
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	
	if Input.is_action_just_pressed("bite"):
		_determine_bite_outcome()

	move_and_slide()


func _determine_bite_outcome():
	var bite_victims: Array[Villager] = $BiteDetector.get_bite_victims()
	if bite_victims.size() > 1:
		pass
	if bite_victims.size() == 1:
		bite_victims[0].queue_free()
	if bite_victims.size() < 1:
		pass
	
