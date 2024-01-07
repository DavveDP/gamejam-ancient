extends CharacterBaseState

func update(delta: float) -> void:
    super.update(delta)

    owner._charge += delta/owner.charge_time
    owner._charge = clamp(owner._charge, 0.0, 1.0)
    owner.update_bar()

    if Input.is_action_just_released("charge_spear"):
        state_machine.transition_to("Cooldown")
    
func exit() -> void:
    owner.throw_spear()

