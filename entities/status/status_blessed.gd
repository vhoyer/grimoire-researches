extends Status
class_name StatusBlessed

func name() -> String: return "blessed"

func spell_modifier(spell: Spell) -> Spell:
	var modded = spell.duplicate(true) as Spell
	modded.mp /= 2
	return modded
