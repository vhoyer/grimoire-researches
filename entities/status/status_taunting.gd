extends Status
class_name StatusTaunting

func action_modifier(action: BattleAction) -> BattleAction:
	if action.targets.find(self.bearer) == -1:
		action.targets.shuffle()
		action.targets[0] = self.bearer
	
	return action
