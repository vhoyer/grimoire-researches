extends Resource
class_name Grimoire

const SIZE := 10

var _list: Array[Spell] = []

var affinities:= Affinities.new();
var stats:= Stats.new();

signal updated;

func _init() -> void:
	_list.resize(SIZE)
	pass

func set_spell(idx: int, spell: Spell) -> void:
	_list[idx] = spell;
	recalculate();
	pass
	
func get_spell(idx: int) -> Spell:
	return _list[idx];

func recalculate() -> void:
	affinities = Affinities.new();
	for spell in _list:
		if spell == null: continue;
		affinities.process_spell(spell);
		if (spell.is_passive):
			for effect in spell.radix.effect:
				var dummy_mage = Mage.new("dummy", self)
				effect.do_effect(spell, dummy_mage, [dummy_mage])
		
	updated.emit();
