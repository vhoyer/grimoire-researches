extends Status
class_name StatusEnraged

func filter_spell_list(caster: Mage, spells: Array[Spell]) -> Array[Spell]:
	return spells.filter(func(spell: Spell):
		var last_action = self.battle_manager.history.get_last_action(caster)
		return last_action.spell == spell
		);
