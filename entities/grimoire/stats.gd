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
		return 1000 + 100 * (vitality - 1)

@export var max_mp: int:
	get():
		return 1000 + 100 * (energy - 1)
