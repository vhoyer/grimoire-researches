extends SpellEffect
class_name SpellEffectStat

func do_effect(action: BattleAction):
	var spell = action.spell
	for target in action.targets:
		target.grimoire.stats.increment_stat_by_element(spell.element, spell.amount)

func revert_effect(action: BattleAction) -> void:
	var spell = action.spell
	for target in action.targets:
		target.grimoire.stats.increment_stat_by_element(spell.element, -spell.amount)
