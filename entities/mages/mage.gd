extends Resource
class_name Mage

@export var name: String;
@export var grimoire: Grimoire;

func _init(name: String, grimoire: Grimoire = Grimoire.new()):
	self.name = name;
	self.grimoire = grimoire;
