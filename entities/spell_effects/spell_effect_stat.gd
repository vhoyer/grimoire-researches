extends SpellEffect
class_name SpellEffectStat

func do_effect(spell: Spell, caster: Mage, targets: Array[Mage]):
	for target in targets:
		target.grimoire.stats.increment_stat_by_element(spell.element, spell.amount)

func revert_effect(spell: Spell, caster: Mage, targets: Array[Mage]) -> void:
	for target in targets:
		target.grimoire.stats.increment_stat_by_element(spell.element, -spell.amount)
