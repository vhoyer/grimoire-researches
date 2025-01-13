extends Status
class_name StatusStats

var element: Spell.Elements:
	get(): return self.spell_origin.element


func name() -> String: return "stat_" + Spell.Elements.find_key(element)


func stats_modifier(stats: Stats) -> Stats:
	var modded = stats.duplicate()
	modded.increment_stat_by_element(element, self.spell_origin.amount)
	return modded
