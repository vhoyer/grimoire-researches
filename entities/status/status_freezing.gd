extends Status
class_name StatusFreezing

func name() -> String: return "freezing"

func filter_action_list(actions: Array[BattleAction]) -> Array[BattleAction]:
	return actions.filter(func(action: BattleAction):
		return action.spell.circle <= 1
		);
