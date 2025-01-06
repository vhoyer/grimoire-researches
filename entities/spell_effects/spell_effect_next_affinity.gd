extends SpellEffect
class_name SpellEffectNextAffinity

func do_effect_once(target: Mage, action: BattleAction):
	var spell = action.spell
	target.grimoire.affinities.increment_affinity(spell.element, spell.amount)

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	var spell = action.spell
	target.grimoire.affinities.increment_affinity(spell.element, -spell.amount)
