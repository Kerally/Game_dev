extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var speed = 200
var player = null  # Создаем переменную для хранения ссылки на игрока
var alive = true

@onready var anim = $AnimatedSprite2D

func _ready():
	# Попробуем захватить узел игрока в начале
	player = get_node_or_null("../player/player")
	if player == null:
		print("Player node not found!")
	else:
		print("Player node successfully found.")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Определяем переменную direction за пределами условия
	var direction = Vector2.ZERO
	if alive == true: 
		# Проверяем, что player существует и chase включен
		if player and chase:
			direction = (player.position - self.position).normalized()
			velocity.x = direction.x * speed
			anim.play("Run")
		else:
			velocity.x = 0
			anim.play("Idle")
		
		# Используем значение direction для поворота моба
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

	move_and_slide()


func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "player":
		chase = true

func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "player":
		chase = false


func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "player":
		death()
		
func death():
	alive = false 
	anim.play("Death")
	await anim.animation_finished
	queue_free()
