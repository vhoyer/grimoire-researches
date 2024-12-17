extends Button

@export var SpellSelectionScene: PackedScene;
@export_range(0, Grimoire.SIZE-1, 1) var slot_index: int = 0;

var grimoire: Grimoire;
var spell_select;

var spell: Spell:
	get():
		if (grimoire == null): return null;
		return grimoire.get_spell(slot_index);
	set(value):
		grimoire.set_spell(slot_index, value);
		update_label()

func _ready() -> void:
	update_label()

func update_label():
	if spell == null:
		self.text = '+'
		return
	self.text = spell.name

func _on_button_down() -> void:
	spell_select = SpellSelectionScene.instantiate()
	get_tree().root.add_child(spell_select)
	spell_select.connect('spell_selected', _on_spell_selected);
	spell_select.connect('cancel', _on_spell_selection_canceled);

func _on_spell_selected(spell: Spell) -> void:
	self.spell = spell;
	get_tree().root.remove_child(spell_select)

func _on_spell_selection_canceled() -> void:
	get_tree().root.remove_child(spell_select)
	pass
