extends Resource
class_name SpellEffect

var get_amount = func(action: BattleAction) -> int:
	return action.spell.amount

func do_effect(action: BattleAction) -> void:
	for target in action.targets:
		do_effect_once(target, action)

func revert_effect(action: BattleAction) -> void:
	for target in action.targets:
		revert_effect_once(target, action)

func turn_effect(action: BattleAction) -> void:
	for target in action.targets:
		turn_effect_once(target, action)

func do_effect_once(target: Mage, action: BattleAction) -> void:
	pass

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	pass

func turn_effect_once(target: Mage, action: BattleAction) -> void:
	pass
