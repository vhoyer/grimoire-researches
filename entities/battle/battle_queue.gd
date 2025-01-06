extends Resource
class_name BattleQueue

signal updated

var queue: Array[BattleTurn] = []
var current: Mage:
	get():
		return queue[0].member

func _init(members: Array[Mage]) -> void:
	for member in members:
		queue.push_back(BattleTurn.new(member))
	queue.shuffle()

func next() -> Mage:
	var turn: BattleTurn = queue.pop_front()
	if !turn.is_temporary:
		queue.push_back(turn)
	updated.emit()
	return current

func is_current(turn: BattleTurn) -> bool:
	return queue[0] == turn
