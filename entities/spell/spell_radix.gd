extends Resource
class_name SpellRadix

@export var id: int = 0
@export var name: String
@export var description: String
@export var element: Spell.Elements

@export var mp: int = 12
@export var amount: int = 1
@export var turns_active: int = 1
@export var chance_primary: float = 1.0/3
@export var chance_secondary: float = 1.0/6
@export var circle: int = 1
@export var turns_casting: int = 1

@export var effect: Array[SpellEffect] = []

@export var constraints: Dictionary = {}

@export var display_name: String:
	get(): return name
