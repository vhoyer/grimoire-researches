extends Status
class_name StatusEnraged

func name() -> String: return "enraged"

func filter_action_list(actions: Array[BattleAction]) -> Array[BattleAction]:
	return actions.filter(func(action: BattleAction):
		var caster = action.caster
		var last_action = self.battle_manager.history.get_last_action(caster)
		return last_action.spell == action.spell
		);
