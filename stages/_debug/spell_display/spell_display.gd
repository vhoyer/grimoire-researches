extends PanelContainer
class_name SpellDisplay

@onready var spell_name: Label = %SpellName
@onready var element: Label = %Element
@onready var description: Label = %Description
@onready var mp: Label = %MP
@onready var turns_casting: Label = %TurnsCasting
@onready var circle: Label = %Circle

func set_values(spell: Spell) -> void:
	spell_name.text = spell.name
	element.text = Spell.Elements.keys()[spell.radix.element]
	description.text = spell.description
	mp.text = str(spell.mp)
	turns_casting.text = str(spell.turns_casting)
	circle.text = str(spell.circle)
