extends RigidBody2D

export var gravity = 200

func _ready():
	add_central_force(Vector2.DOWN * gravity)
