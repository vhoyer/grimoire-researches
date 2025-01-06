extends Status
class_name StatusBurning

const BURNING_DAMAGE = 100

func every_turn(action: BattleAction) -> void:
	action.caster.hp -= BURNING_DAMAGE
