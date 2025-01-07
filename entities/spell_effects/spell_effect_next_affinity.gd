extends SpellEffect
class_name SpellEffectNextAffinity

func do_effect_once(target: Mage, action: BattleAction):
	target.grimoire.affinities.increment_affinity(action.spell.element, self.get_amount.call(action))

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	target.grimoire.affinities.increment_affinity(action.spell.element, -1 * self.get_amount.call(action))

# TODO: HOW DO I KNOW WHEN TO REVERT THIS SHIT
