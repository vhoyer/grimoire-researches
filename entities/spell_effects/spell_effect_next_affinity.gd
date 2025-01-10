extends SpellEffect
class_name SpellEffectNextAffinity

func do_effect_once(target: Mage, action: BattleAction):
	target.grimoire.affinities.increment_affinity(action.spell.element, self.mod_amount(action.spell.amount))

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	target.grimoire.affinities.increment_affinity(action.spell.element, -1 * self.mod_amount(action.spell.amount))
