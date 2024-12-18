extends Resource
class_name Mage

@export var name: String;
@export var grimoire: Grimoire;

var hp: int
var mp: int

func _init(name: String, grimoire: Grimoire = Grimoire.new()):
	self.name = name;
	self.grimoire = grimoire;
	hp = grimoire.stats.max_hp
	mp = grimoire.stats.max_mp
