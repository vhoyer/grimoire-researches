@tool
extends Resource
class_name Mage

@export var name: String:
	set(value):
		name = value
		updated.emit()

@export var grimoire: Grimoire:
	set(value):
		if (grimoire and grimoire.updated.is_connected(_on_grimoire_updated)):
			grimoire.updated.disconnect(_on_grimoire_updated)
		grimoire = value
		grimoire.updated.connect(_on_grimoire_updated)
		updated.emit()

@export var hp: int:
	set(value):
		hp = value
		updated.emit()
@export var mp: int:
	set(value):
		mp = value
		updated.emit()

var statuses:= MageStatuses.new(updated)

var affinities: Affinities:
	get():
		return statuses.process('affinities_modifier', [grimoire.affinities])

var stats: Stats:
	get():
		return statuses.process('stats_modifier', [grimoire.stats])


## Memory of in_progress spells be it passives or casting
var in_progress: Dictionary = {}
var in_casting: BattleAction:
	get():
		var casting = [] as Array[BattleAction]
		for action: BattleAction in in_progress.values():
			if !action.spell.is_castable: continue
			if !action.updated.is_connected(updated.emit):
				action.updated.connect(updated.emit)
			return action
		return null

signal updated

func _init(name: String = 'dummy', grimoire: Grimoire = Grimoire.new()):
	self.name = name;
	self.grimoire = grimoire;
	reset_combat_state()

func reset_combat_state() -> void:
	hp = grimoire.stats.max_hp
	mp = grimoire.stats.max_mp
	statuses = MageStatuses.new(updated)

func can_cast_spell(spell: Spell) -> bool:
	if (spell.mp > self.mp): return false
	return true

func get_action_list() -> Array[BattleAction]:
	var actions: Array[BattleAction] = []
	
	actions.append_array(grimoire.spells
		.filter(func(spell: Spell):
			return !spell.is_passive and !spell.is_initial
			)
		.map(func(spell: Spell):
			return BattleAction.new(spell, self)
			))
	
	if in_casting:
		in_casting.type = BattleAction.Type.keep_casting
		in_casting.label = tr("KEEP_CAST").format({
			'spell_name': in_casting.spell.name,
			})
		actions.push_front(in_casting)
	
	return actions


func _on_grimoire_updated() -> void:
	reset_combat_state()
	updated.emit()
