extends CharacterBaseState

func update(delta: float) -> void:
	
	super.update(delta)	
	if Input.is_action_pressed("charge_spear"):
		state_machine.transition_to("Charge")
	