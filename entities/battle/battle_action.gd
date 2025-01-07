extends Node
class_name BattleAction

enum Type {
	system_msg,
	magic,
}


var type:= Type.magic

var label: String = "":
	get():
		if label: return label
		if spell: return spell.name
		assert(false, "Error getting a label text")
		return "undefined"
var message: String

var spell: Spell
var caster: Mage
var targets: Array[Mage]

var turns_casting = 0
var is_casting: bool:
	get(): return turns_casting < spell.turns_casting
	
var turns_active = 0
var is_active: bool:
	get(): return not is_casting and (spell.is_passive or turns_active < spell.turns_active)

func _init(spell: Spell = Spell.new(), caster: Mage = Mage.new(), targets: Array[Mage] = []):
	self.spell = spell
	self.caster = caster
	self.targets = targets
