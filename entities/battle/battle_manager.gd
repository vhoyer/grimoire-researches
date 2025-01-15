extends Node
class_name BattleManager

static var instance: BattleManager:
	set(value):
		if instance:
			print_debug("INFO: battle manager singleton is being cleared")
			instance.queue_free()
		instance = value

var history:= BattleHistory.new()
var queue: BattleQueue
var resolver:= BattleSpellResolver.new()

var party_a:= Party.new([
	Mage.new("André", SpellList.generate_grimoire()),
	Mage.new("Doka", SpellList.generate_grimoire()),
	Mage.new("Julio", SpellList.generate_grimoire()),
])

var party_b:= Party.new([
	Mage.new("Tristam", SpellList.generate_grimoire()),
	Mage.new("Patrick", SpellList.generate_grimoire()),
	Mage.new("Lucas", SpellList.generate_grimoire()),
])

var combatants: Array[Mage]:
	get(): return party_a.members + party_b.members

func _init(party_a: Party, party_b: Party) -> void:
	self.party_a = party_a
	self.party_b = party_b

	for mage in combatants:
		resolver.populate_in_progress_spells(mage)

	BattleManager.instance = self
	queue = BattleQueue.new(combatants)
	turn_started.emit(queue.current)

signal turn_started(combatant: Mage)

func turn_act(action: BattleAction) -> void:
	resolver.resolve(action)
	
	action = action.caster.statuses.process('action_modifier', [action])
	
	action.caster.statuses.auto_clear(action)
	for target in action.targets:
		target.statuses.auto_clear(action)
	
	history.write(action)
	
	turn_started.emit(queue.next())


func end_battle() -> void:
	for mage in combatants:
		mage.in_progress = {}
