@tool
extends Resource
class_name Mage

@export var name: String:
	set(value):
		name = value
		updated.emit()

@export var grimoire: Grimoire:
	set(value):
		grimoire = value
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

## Memory of in_progress spells be it passives or casting
var in_progress: Dictionary = {}
var in_casting: Array[BattleAction]:
	get():
		var casting = [] as Array[BattleAction]
		for action: BattleAction in in_progress.values():
			if !action.spell.is_castable: continue
			casting.push_back(action)
		casting.make_read_only()
		return casting

signal updated

func _init(name: String = 'dummy', grimoire: Grimoire = Grimoire.new()):
	self.name = name;
	self.grimoire = grimoire;
	hp = grimoire.stats.max_hp
	mp = grimoire.stats.max_mp

# TODO actually use this function on the action selection
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
	
	for action: BattleAction in in_casting:
		action.label = tr("KEEP_CAST").format({
			'spell_name': action.spell.name,
			})
		actions.push_front(action)
	
	return actions
