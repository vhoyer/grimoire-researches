extends SpellEffect
class_name SpellEffectStatus

@export var status: Status

func do_effect_once(target: Mage, action: BattleAction) -> void:
	var status = self.status.duplicate(true) as Status
	status.bearer = target
	status.spell_origin = action.spell
	status.battle_manager = BattleManager.instance
	status.status_begin()
	target.statuses.add(status)

func revert_effect_once(target: Mage, action: BattleAction) -> void:
	if status.clear_type() != Status.ClearType.turn: return
	target.statuses.remove(status.name())
