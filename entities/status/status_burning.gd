extends Status
class_name StatusBurning

func name() -> String: return "burning"

const BURNING_DAMAGE = 100

func action_modifier(action: BattleAction) -> BattleAction:
	action.caster.hp -= BURNING_DAMAGE
	return action
