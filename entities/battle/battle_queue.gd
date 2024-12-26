extends Resource
class_name BattleQueue

signal updated

var queue = []

func _init(members: Array[Mage]) -> void:
	queue = members
	queue.shuffle()
