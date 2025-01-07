extends SpellEffect
class_name SpellEffectLastAffinity

func do_effect_once(target: Mage, action: BattleAction):
	# TODO make this works, how do I get the last spell's element
	# Currently only used by abs
	target.grimoire.affinities.increment_affinity(action.spell.element, self.get_amount.call(action))

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	target.grimoire.affinities.increment_affinity(action.spell.element, -1 * self.get_amount.call(action))
