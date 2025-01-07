extends SpellEffect
class_name SpellEffectInvert

@export var effect: SpellEffect

var get_amount_invert = func(action: BattleAction) -> int:
	return action.spell.amount * -1

func do_effect_once(target: Mage, action: BattleAction):
	effect.get_amount = self.get_amount_invert
	effect.do_effect_once(target, action)

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	effect.get_amount = self.get_amount_invert
	effect.revert_effect_once(target, action)
