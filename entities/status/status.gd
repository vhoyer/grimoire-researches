extends Resource
class_name Status

var bearer: Mage
var battle_manager: BattleManager

func name() -> String:
	assert(false, "you must override the name function")
	return ""

func filter_action_list(actions: Array[BattleAction]) -> Array[BattleAction]:
	return actions

func action_modifier(action: BattleAction) -> BattleAction:
	return action

func spell_cost_modifier(cost: int) -> int:
	return cost
