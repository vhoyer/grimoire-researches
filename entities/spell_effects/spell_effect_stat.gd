extends SpellEffect
class_name SpellEffectStat

func do_effect_once(target: Mage, action: BattleAction):
	var spell = action.spell
	target.grimoire.stats.increment_stat_by_element(spell.element, spell.amount)

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	var spell = action.spell
	target.grimoire.stats.increment_stat_by_element(spell.element, -spell.amount)
