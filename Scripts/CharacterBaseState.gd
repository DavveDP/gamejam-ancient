class_name CharacterBaseState
extends State



func update(delta: float) -> void:
	
	owner._rotation_direction = Input.get_axis("Aim Left", "Aim Right")
	owner._aim_angle += owner._rotation_direction * owner.rotation_speed * delta
	owner._aim_angle = clamp(owner._aim_angle, -PI/4, PI/4)
	owner.update_arrow()

	get_input()
	owner.move_and_slide()


func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	owner.velocity = input_direction * owner.movement_speed

		
