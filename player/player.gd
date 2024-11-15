extends CharacterBody2D
@onready var _animation_player = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -650.0
var doule_jump = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		doule_jump = false
		_animation_player.play("Jump")
	if Input.is_action_just_pressed("ui_accept") and !is_on_floor() and !doule_jump:
		velocity.y = JUMP_VELOCITY
		_animation_player.stop()
		_animation_player.play("Jump")
		doule_jump = true
		
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if velocity.y == 0:
			_animation_player.play("Run")
		velocity.x = direction * SPEED
	else:
		if velocity.y == 0:
			_animation_player.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction == -1:
		_animation_player.flip_h = false
	elif direction == 1:
		_animation_player.flip_h = true

	move_and_slide()
