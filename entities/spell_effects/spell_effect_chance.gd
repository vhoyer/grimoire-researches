extends SpellEffect
class_name SpellEffectChance

enum Mode {
	Primary,
	Secondary,
}

@export var mode: Mode
@export var effect: SpellEffect

var chance_mngr:= ChanceManager.new()

var affected_targets: Array[Mage] = []

func chance(spell: Spell) -> float:
	match mode:
		Mode.Primary: return spell.chance_primary
		Mode.Secondary: return spell.chance_secondary
	return 1.0

func do_effect(action: BattleAction) -> void:
	for target in action.targets:
		if !chance_mngr.roll(chance(action.spell)): continue
		effect.do_effect_once(target, action)
		affected_targets.push_back(target)

func revert_effect(action: BattleAction) -> void:
	for target in affected_targets:
		effect.revert_effect_once(target, action)
	affected_targets.clear()

func turn_effect(action: BattleAction) -> void:
	for target in action.targets:
		if !chance_mngr.roll(chance(action.spell)): continue
		effect.turn_effect_once(target, action)
