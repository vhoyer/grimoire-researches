extends Resource
class_name BattleHistory

var history: Array[BattleAction] = []
var last_actions: Dictionary = {}
var last_targeted: Dictionary = {}

func write(action: BattleAction) -> void:
	history.push_back(action)
	last_actions[action.caster] = action
	for target in action.targets:
		last_targeted[target] = action

func get_last_action(caster: Mage) -> BattleAction:
	return last_actions[caster]

func get_last_action_targeted(caster: Mage) -> BattleAction:
	return last_targeted[caster]
