extends CharacterBaseState

func update(delta: float) -> void:
    super.update(delta)

    owner._charge -= delta/owner.recharge_time
    owner.update_bar()

    if owner._charge <= 0:
        state_machine.transition_to("Idle")
