extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("Aim Left", "Aim Right")

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	rotation = clamp(rotation, -PI/4, PI/4)
	move_and_slide()
