extends SpellEffect
class_name SpellEffectTurnShift

func do_effect_once(target: Mage, action: BattleAction) -> void:
	var queue = BattleManager.instance.queue
	queue.shift_turn(target, action.spell.amount)
