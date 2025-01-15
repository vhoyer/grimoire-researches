extends Node
class_name BattleAction

signal updated

enum Type {
	system_msg,
	keep_casting,
	magic,
}


var type:= Type.magic:
	set(value):
		type = value
		updated.emit()

var label: String:
	set(value):
		label = value
		updated.emit()
	get():
		if label: return label
		if spell: return spell.name
		assert(false, "Error getting a label text")
		return "undefined"
var message: String:
	set(value):
		message = value
		updated.emit()

var spell: Spell:
	set(value):
		spell = value
		updated.emit()
var caster: Mage:
	set(value):
		caster = value
		updated.emit()
var targets: Array[Mage]:
	set(value):
		targets = value
		updated.emit()

var turns_casting = 0:
	set(value):
		turns_casting = value
		updated.emit()
var turns_casting_needed: int:
	get():
		var modded = caster.statuses.process("spell_modifier", [spell]) as Spell
		return modded.turns_casting
var is_casting: bool:
	get(): return turns_casting < turns_casting_needed
	
var turns_active = 0:
	set(value):
		turns_active = value
		updated.emit()
var is_active: bool:
	get(): return not is_casting and (spell.is_passive or turns_active < spell.turns_active)

func _init(spell: Spell = Spell.new(), caster: Mage = Mage.new(), targets: Array[Mage] = []):
	self.spell = spell
	self.caster = caster
	self.targets = targets
