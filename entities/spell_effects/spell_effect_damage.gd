extends SpellEffect
class_name SpellEffectDamage

func do_effect(spell: Spell, caster: Mage, targets: Array[Mage]):
	caster.mp -= spell.mp
	for target in targets:
		# TODO: deal with affinity damage
		target.hp -= spell.amount
	pass
