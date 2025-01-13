extends Status
class_name StatusAffinity

enum Type {
	last,
	next,
}

@export var type: Type = Type.next

var element: Spell.Elements:
	get():
		if element:
			return element
		return self.spell_origin.element


func name() -> String:
	if type == Type.last:
		return "affinity_last"
	return "affinity_" + Spell.Elements.find_key(element)

func status_begin() -> void:
	var last_action = self.battle_manager.history.get_last_action_targeted(self.bearer)
	var last_element = last_action.spell.element
	element = last_element


func affinities_modifier(affinities: Affinities) -> Affinities:
	var modded = affinities.duplicate()
	modded.increment_affinity(element, self.spell_origin.amount)
	return modded


func clear_type() -> ClearType:
	return ClearType.custom

func should_clear(action: BattleAction) -> bool:
	if not action.targets.has(self.bearer): return false
	if action.spell.element != element: return false
	return true
