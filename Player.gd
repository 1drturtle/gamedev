extends KinematicBody2D


export var acceleration = 750
var velocity = Vector2.ZERO
export var gravity = 200
var jump_force = 120
var die = 0

var score = 0

export var friction = 0.15
export var max_speed = 80
export var jumps = 3
export var hp = 5

onready var sprite = $Sprite
onready var animation_player = $"Player Animation"
onready var hp_label = $"Player HP"
onready var score_label = $"Player Score"
onready var crateInstance = preload("res://Crate.tscn")

func _physics_process(delta):
	var x_input = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	
	if x_input != 0:
		velocity.x += acceleration * x_input * delta
		sprite.flip_h = x_input < 0
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
		animation_player.play("Run")
	else:
		animation_player.play("Idle")
		velocity.x = lerp(velocity.x, 0, friction)
	
	velocity.y += gravity * delta
	
	if is_on_floor():
		jumps = 3
		velocity.y += 10
	else:
		animation_player.play("Jump")
	if Input.is_action_just_pressed('ui_up') and jumps > 0:
		velocity.y = -jump_force
		jumps -= 1
		
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, true)
	
	# update label
	score_label.text = str(score) + " points"
	hp_label.text = str(hp) + " hp"


func _on_Hurtbox_area_entered(area):
	hp -= 1
