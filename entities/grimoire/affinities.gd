extends Resource
class_name Affinities

@export var fire: int:
	get(): return _elements[Spell.Elements.fire]
@export var water: int:
	get(): return _elements[Spell.Elements.water]
@export var earth: int:
	get(): return _elements[Spell.Elements.earth]
@export var wind: int:
	get(): return _elements[Spell.Elements.wind]
@export var light: int:
	get(): return _elements[Spell.Elements.light]
@export var dark: int:
	get(): return _elements[Spell.Elements.dark]

var _elements: PackedInt32Array = [0];

const CIRCLE_PENALTY = {
	1: 0,
	2: -1,
	3: -2,
}

func _init() -> void:
	_elements.resize(6)
	_elements.fill(0)
	pass

func process_spell(spell: Spell) -> void:
	var opposite_index = get_opposite_element(spell.element)
	var affinity = CIRCLE_PENALTY[spell.circle]
	_elements[opposite_index] = min(_elements[opposite_index], affinity)
	pass

func get_opposite_element(el: Spell.Elements) -> Spell.Elements:
	match el:
		Spell.Elements.fire: return Spell.Elements.water;
		Spell.Elements.water: return Spell.Elements.fire;
		Spell.Elements.earth: return Spell.Elements.wind;
		Spell.Elements.wind: return Spell.Elements.earth;
		Spell.Elements.light: return Spell.Elements.dark;
		Spell.Elements.dark: return Spell.Elements.light;
	assert(false, "Error, wtf why did it even get here????")
	return 0;
