extends CanvasLayer

@onready var v_box_container: VBoxContainer = $VBoxContainer/ScrollContainer/VBoxContainer
const SPELL_DISPLAY = preload("res://stages/_debug/spell_display/spell_display.tscn")

func _ready() -> void:
	for spell in SpellList.all:
		var spell_display = SPELL_DISPLAY.instantiate()
		v_box_container.add_child(spell_display)
		spell_display.call_deferred("set_values", spell)
		


func _on_button_button_down() -> void:
	var copyme = ""
	
	for spell in SpellList.all:
		copyme += spell.name
		copyme += "\t"
		copyme += Spell.Elements.find_key(spell.element)
		copyme += "\t"
		copyme += spell.description.replace("\n", " ")
		copyme += "\t"
		copyme += str(spell.mp)
		copyme += "\t"
		copyme += str(spell.turns_casting)
		copyme += "\t"
		copyme += str(spell.circle)
		copyme += "\n"
	
	DisplayServer.clipboard_set(copyme)
