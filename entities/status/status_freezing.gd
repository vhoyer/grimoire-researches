extends Status
class_name StatusFreezing

func filter_spell_list(caster: Mage, spells: Array[Spell]) -> Array[Spell]:
	return spells.filter(func(spell: Spell):
		return spell.circle <= 1
		);
