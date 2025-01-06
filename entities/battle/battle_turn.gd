extends Node
class_name BattleTurn
	
var member: Mage
var is_temporary: bool

func _init(member = Mage.new(), is_temporary = false):
	self.member = member
	self.is_temporary = is_temporary
