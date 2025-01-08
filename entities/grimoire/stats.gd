extends Resource
class_name Stats

@export var power = 1;
@export var vitality = 1;
@export var endurance = 1;
@export var agility = 1;
@export var luck = 1;
@export var energy = 1;

@export var max_hp: int:
	get():
		return 1000 + 200 * (vitality - 1)

@export var max_mp: int:
	get():
		return 1000 + 100 * (energy - 1)

func increment_stat_by_element(element: Spell.Elements, value: int) -> void:
	const stat_map = {
		Spell.Elements.fire: 'power',
		Spell.Elements.water: 'vitality',
		Spell.Elements.earth: 'endurance',
		Spell.Elements.wind: 'agility',
		Spell.Elements.light: 'luck',
		Spell.Elements.dark: 'energy',
	}
	self[stat_map[element]] += value;
