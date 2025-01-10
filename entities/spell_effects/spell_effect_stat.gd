extends SpellEffect
class_name SpellEffectStat

func do_effect_once(target: Mage, action: BattleAction):
	target.grimoire.stats.increment_stat_by_element(action.spell.element, self.mod_amount(action.spell.amount))

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	target.grimoire.stats.increment_stat_by_element(action.spell.element, -1 * self.mod_amount(action.spell.amount))
