extends Resource
class_name BattleHistory

var history: Array[BattleAction] = []
var last_actions: Dictionary = {}

func write(action: BattleAction) -> void:
	history.push_back(action)
	last_actions[action.caster] = action

func get_last_action(caster: Mage) -> BattleAction:
	return last_actions[caster]
