extends Resource
class_name Status

var bearer: Mage
var battle_manager: BattleManager

func every_turn(action: BattleAction) -> void:
	pass

func filter_spell_list(caster: Mage, spells: Array[Spell]) -> Array[Spell]:
	return spells

func spell_cost_modifier(cost: int) -> int:
	return cost

func action_modifier(action: BattleAction) -> BattleAction:
	return action
