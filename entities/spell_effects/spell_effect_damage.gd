extends SpellEffect
class_name SpellEffectDamage

func do_effect_once(target: Mage, action: BattleAction):
	var damage = target.affinities.modify_damage(action.spell)
	if damage < 0:
		damage = int(action.caster.affinities.modify_damage(action.spell) * 0.5)
		action.caster.hp -= self.mod_amount(damage)
	else:
		target.hp -= self.mod_amount(damage)
