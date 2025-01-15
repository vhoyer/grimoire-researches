extends Status
## modifies turns nedded to cast the spell
class_name StatusQuickCast

var state: String = 'begin'

func name() -> String: return "quick_cast"

func clear_type() -> ClearType:
	return ClearType.custom

func should_clear(action: BattleAction) -> bool:
	if action.caster != self.bearer: return false
	
	if state == 'begin' and action.spell == self.spell_origin:
		state = 'check'
		
	if state == 'check' and self.bearer.in_casting == null:
		state = 'wait'
	
	if ['check', 'wait'].has(state) and self.bearer.in_casting != null:
		state = 'in_effect'
	
	if state == 'in_effect' and self.bearer.in_casting == null:
		state = 'end'
	
	return state == 'end'


func spell_modifier(spell: Spell) -> Spell:
	var modded = spell.duplicate(true) as Spell
	modded.turns_casting += self.spell_origin.amount
	return modded
