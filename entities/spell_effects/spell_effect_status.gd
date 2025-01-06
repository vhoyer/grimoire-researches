extends Resource
class_name SpellEffectStatus

@export var status: Status

func do_effect_once(target: Mage, action: BattleAction) -> void:
	target.status_add(status)

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	target.status_remove(status)
