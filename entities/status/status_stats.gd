extends Status
class_name StatusStats

@export var stat: Stats.Type
@export_enum("-", "+") var indicator: String = "+"

func name() -> String: return indicator + "stat_" + Stats.Type.find_key(stat)


func stats_modifier(stats: Stats) -> Stats:
	var modded = stats.duplicate()
	modded.increment_stat(stat, self.spell_origin.amount)
	return modded
