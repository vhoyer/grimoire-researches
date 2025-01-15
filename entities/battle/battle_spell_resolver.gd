extends Node
class_name BattleSpellResolver

func populate_in_progress_spells(caster: Mage) -> void:
	var passives = caster.grimoire.spells.filter(func(spell: Spell):
		return !spell.is_castable
		)
	for spell in passives:
		add(BattleAction.new(spell, caster, [caster]))


func resolve(action: BattleAction) -> void:
	add(action)
	process(action.caster)

func add(action: BattleAction) -> void:
	var caster = action.caster
	var spell = action.spell
	
	var in_progress = caster.in_progress
	in_progress.get_or_add(spell, action)
	
	for wip_action: BattleAction in in_progress.values():
		if wip_action.is_casting and wip_action.spell.name != spell.name:
			in_progress.erase(wip_action.spell)
	
	if (in_progress[spell].turns_casting == 0):
		spell.charge_cost(caster)
	
	in_progress[spell].turns_casting += 1

func process(caster: Mage) -> void:
	var in_progress = caster.in_progress
	for action: BattleAction in in_progress.values():
		if action.is_casting: continue
		var spell = action.spell
		
		if spell.is_passive:
			spell.charge_cost(action.caster)
		
		# start of effect
		if action.turns_active == 0:
			spell.do_effect(action)
		
		spell.turn_effect(action)
		action.turns_active += 1
		
		# end of effect
		if action.turns_active > 0 and not action.is_active:
			spell.revert_effect(action)
			in_progress.erase(spell)
			caster.updated.emit()
