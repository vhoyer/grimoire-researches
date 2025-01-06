extends SpellEffect
class_name SpellEffectDamage

func do_effect(action: BattleAction):
	for target in action.targets:
		# TODO: deal with affinity damage
		target.hp -= action.spell.amount
	pass
