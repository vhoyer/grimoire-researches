extends Resource
class_name SpellEffectChance

enum Mode {
	Primary,
	Secondary,
}

@export var mode: Mode;

func do_effect(action: BattleAction) -> void:
	pass

func revert_effect(action: BattleAction) -> void:
	pass

func turn_effect(action: BattleAction) -> void:
	pass
