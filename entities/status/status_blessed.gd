extends Status
class_name StatusBlessed

func name() -> String: return "blessed"

func spell_cost_modifier(cost: int) -> int:
	return cost / 2
