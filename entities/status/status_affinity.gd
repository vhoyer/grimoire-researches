extends Status
class_name StatusAffinity

enum Type {
	last,
	next,
}

@export var type: Type = Type.next

@export var element: Spell.Elements = Spell.Elements.dark
@export_enum("-", "+") var indicator: String = "+"


func name() -> String:
	if type == Type.last:
		return "affinity_last"
	return indicator + "affinity_" + Spell.Elements.find_key(element)

func status_begin() -> void:
	if type == Type.last:
		var last_action = self.battle_manager.history.get_last_action_targeted(self.bearer)
		var last_element = last_action.spell.element
		element = last_element


func affinities_modifier(affinities: Affinities) -> Affinities:
	var modded = affinities.duplicate()
	modded.increment_affinity(element, self.spell_origin.amount)
	return modded


func clear_type() -> ClearType:
	if type == Type.last:
		return ClearType.turn
	return ClearType.custom
	

func should_clear(action: BattleAction) -> bool:
	if not action.targets.has(self.bearer): return false
	if action.spell.element != element: return false
	return true
