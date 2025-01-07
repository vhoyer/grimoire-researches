extends SpellEffect
class_name SpellEffectStatus

@export var status: Status

func do_effect_once(target: Mage, action: BattleAction) -> void:
	var status = self.status.duplicate(true) as Status
	status.bearer = target
	status.battle_manager = BattleManager.instance
	target.statuses.add(status)

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	target.statuses.remove(status.name())
