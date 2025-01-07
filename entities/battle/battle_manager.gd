extends Node
class_name BattleManager

var history:= BattleHistory.new()
var queue: BattleQueue
var resolver:= BattleSpellResolver.new()

var party_a: Array[Mage] = [
	Mage.new("André", SpellList.generate_grimoire()),
	Mage.new("Doka", SpellList.generate_grimoire()),
	Mage.new("Julio", SpellList.generate_grimoire()),
]

var party_b: Array[Mage] = [
	Mage.new("Tristam", SpellList.generate_grimoire()),
	Mage.new("Patrick", SpellList.generate_grimoire()),
	Mage.new("Lucas", SpellList.generate_grimoire()),
]

var combatants: Array[Mage]:
	get(): return party_a + party_b

func _init() -> void:
	queue = BattleQueue.new(combatants)
	turn_started.emit(queue.current)

signal turn_started(combatant: Mage)

func turn_act(action: BattleAction) -> void:
	resolver.resolve(action)
	history.write(action)
	turn_started.emit(queue.next())
