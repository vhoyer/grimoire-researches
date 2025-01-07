extends Status
class_name StatusCursed

func name() -> String: return "cursed"

func action_modifier(action: BattleAction) -> BattleAction:
	action.caster.hp -= action.spell.amount / 2
	return action
