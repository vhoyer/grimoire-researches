extends Status
class_name StatusRooted

func filter_spell_list(caster: Mage, spells: Array[Spell]) -> Array[Spell]:
	return spells.filter(func(spell: Spell):
		return spell.turns_casting <= 1
		);
