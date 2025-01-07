extends Resource
class_name BattleQueue

signal updated

var queue: Array[BattleTurn] = []
var current: Mage:
	get():
		return queue[0].combatant

func _init(combatants: Array[Mage]) -> void:
	for combatant in combatants:
		queue.push_back(BattleTurn.new(combatant))
	queue.shuffle()

func next() -> Mage:
	var turn: BattleTurn = queue.pop_front()
	if !turn.is_temporary:
		queue.push_back(turn)
	updated.emit()
	return current

func is_current(turn: BattleTurn) -> bool:
	return queue[0] == turn
