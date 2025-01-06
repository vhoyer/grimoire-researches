extends Node
class_name BattleManager

var queue: BattleQueue
var resolver:= BattleSpellResolver.new()

var party_a: Array[Mage] = [
	Mage.new("André"),
	Mage.new("Doka"),
	Mage.new("Julio"),
]

var party_b: Array[Mage] = [
	Mage.new("Tristam"),
	Mage.new("Patrick"),
	Mage.new("Lucas"),
]

var members: Array[Mage]:
	get(): return party_a + party_b

func _init() -> void:
	queue = BattleQueue.new(members)
	turn_started.emit(queue.current)

signal turn_started(member: Mage)

func turn_act(action: BattleAction) -> void:
	resolver.resolve(action)
	turn_started.emit(queue.next())
