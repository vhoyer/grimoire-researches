extends SpellEffect
class_name SpellEffectLastAffinity

func do_effect_once(target: Mage, action: BattleAction):
	var last_action = BattleManager.instance.history.get_last_action_targeted(action.caster)
	var last_element = last_action.spell.element
	target.grimoire.affinities.increment_affinity(last_element, self.get_amount.call(action))

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	target.grimoire.affinities.increment_affinity(action.spell.element, -1 * self.get_amount.call(action))
