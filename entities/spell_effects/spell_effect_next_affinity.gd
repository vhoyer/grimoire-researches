extends SpellEffect
class_name SpellEffectNextAffinity

func do_effect(spell: Spell, caster: Mage, targets: Array[Mage]):
	for target in targets:
		target.grimoire.affinities.increment_affinity(spell.element, spell.amount)

func revert_effect(spell: Spell, caster: Mage, targets: Array[Mage]) -> void:
	for target in targets:
		target.grimoire.affinities.increment_affinity(spell.element, -spell.amount)