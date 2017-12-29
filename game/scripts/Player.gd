extends Area2D
var screensize
export (int) var SPEED
var velocity = Vector2()

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
