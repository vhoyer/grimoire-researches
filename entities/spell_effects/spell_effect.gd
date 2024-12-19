extends Resource
class_name SpellEffect

func charge_cost(spell: Spell, caster: Mage):
	caster.mp -= spell.mp

func do_effect(spell: Spell, caster: Mage, targets: Array[Mage]) -> void:
	pass

func revert_effect(spell: Spell, caster: Mage, targets: Array[Mage]) -> void:
	pass
