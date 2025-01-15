extends Resource
class_name Status

enum ClearType {
	custom,
	turn,
}

var bearer: Mage
var spell_origin: Spell
var battle_manager: BattleManager

func name() -> String:
	assert(false, "you must override the name function")
	return ""

func clear_type() -> ClearType:
	return ClearType.turn

func should_clear(action: BattleAction) -> bool:
	return true

func status_begin() -> void:
	pass


func filter_action_list(actions: Array[BattleAction]) -> Array[BattleAction]:
	return actions

func action_modifier(action: BattleAction) -> BattleAction:
	return action

func spell_modifier(spell: Spell) -> Spell:
	return spell

func affinities_modifier(affinities: Affinities) -> Affinities:
	return affinities

func stats_modifier(stats: Stats) -> Stats:
	return stats
