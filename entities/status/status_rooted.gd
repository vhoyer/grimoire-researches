extends Status
class_name StatusRooted

func name() -> String: return "rooted"

func filter_action_list(actions: Array[BattleAction]) -> Array[BattleAction]:
	return actions.filter(func(action: BattleAction):
		return action.spell.turns_casting <= 1
		);
