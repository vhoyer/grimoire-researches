extends SpellEffect
class_name SpellEffectNextAffinity

func do_effect(action: BattleAction):
	var spell = action.spell
	for target in action.targets:
		target.grimoire.affinities.increment_affinity(spell.element, spell.amount)

func revert_effect(action: BattleAction) -> void:
	var spell = action.spell
	for target in action.targets:
		target.grimoire.affinities.increment_affinity(spell.element, -spell.amount)
