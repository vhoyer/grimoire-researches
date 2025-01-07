extends Status
class_name StatusWet

func name() -> String: return "wet"

var chance = ChanceManager.new()
var FAIL_CHANCE = 1.0/3

func action_modifier(action: BattleAction) -> BattleAction:
	if (chance.roll(FAIL_CHANCE)):
		action.type = BattleAction.Type.system_msg
		action.message = tr("WET_FAIL")
	return action
