extends Status
class_name StatusCursed

func every_turn(action: BattleAction) -> void:
	action.caster.hp -= action.spell.amount / 2
