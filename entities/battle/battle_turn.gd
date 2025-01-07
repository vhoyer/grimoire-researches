extends Node
class_name BattleTurn
	
var combatant: Mage
var is_temporary: bool

func _init(combatant = Mage.new(), is_temporary = false):
	self.combatant = combatant
	self.is_temporary = is_temporary
