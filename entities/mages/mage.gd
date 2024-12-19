extends Resource
class_name Mage

@export var name: String;
@export var grimoire: Grimoire;

var hp: int:
	set(value):
		hp = value
		updated.emit()
var mp: int:
	set(value):
		mp = value
		updated.emit()

signal updated

func _init(name: String, grimoire: Grimoire = Grimoire.new()):
	self.name = name;
	self.grimoire = grimoire;
	hp = grimoire.stats.max_hp
	mp = grimoire.stats.max_mp
