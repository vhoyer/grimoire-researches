extends SpellEffect
class_name SpellEffectNextAffinity

func do_effect_once(target: Mage, action: BattleAction):
	target.grimoire.affinities.increment_affinity(action.spell.element, action.spell.amount)

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	target.grimoire.affinities.increment_affinity(action.spell.element, -1 * action.spell.amount)
