extends CanvasLayer

@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer
const SPELL_DISPLAY = preload("res://stages/_debug/spell_display/spell_display.tscn")

func _ready() -> void:
	for spell in SpellList.all:
		var spell_display = SPELL_DISPLAY.instantiate()
		v_box_container.add_child(spell_display)
		spell_display.call_deferred("set_values", spell)
		
