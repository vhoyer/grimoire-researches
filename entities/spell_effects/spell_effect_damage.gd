extends SpellEffect
class_name SpellEffectDamage

func do_effect_once(target: Mage, action: BattleAction):
	# TODO: deal with affinity damage
	target.hp -= action.spell.amount
