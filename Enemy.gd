extends KinematicBody2D


export var acceleration = 50
export var friction = 0.25
export var gravity = 200

onready var sprite = $AnimatedSprite
onready var floorHit = $FloorHit
onready var wallHit = $"Wall Hit"

var velocity = Vector2.ZERO
var direction = -1

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = acceleration * direction
	if direction == -1:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
	velocity = move_and_slide(velocity, Vector2.UP)
	if (wallHit.is_colliding() or !floorHit.is_colliding()):
		direction *= -1
		floorHit.position.x *= -1
		wallHit.cast_to.x *= -1
