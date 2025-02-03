extends Resource
class_name BattleQueue

signal updated

var queue: Array[BattleTurn] = []
var current: Mage:
	get():
		return queue.front().combatant

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

func shift_turn(combatant: Mage, shift: int) -> void:
	var turn_index = Util.find_custom(queue, func(turn: BattleTurn):
		return turn.combatant == combatant
		)
	var turn = queue.pop_at(turn_index)
	var new_index = max(min(turn_index - shift, queue.size()), 0)
	queue.insert(new_index, turn)
