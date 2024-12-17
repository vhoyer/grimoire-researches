extends Button

@export var SpellSelectionScene: PackedScene;
@export_range(0, Grimoire.SIZE-1, 1) var slot_index: int = 0;

var grimoire: Grimoire;
var spell_select;

var spell: Spell:
	get():
		return grimoire.get_spell(slot_index);
	set(value):
		grimoire.set_spell(slot_index, value);
		if value == null:
			self.text = '+'
			return
		self.text = value.name

func _on_button_down() -> void:
	spell_select = SpellSelectionScene.instantiate()
	get_tree().root.add_child(spell_select)
	spell_select.connect('spell_selected', _on_spell_selected);

func _on_spell_selected(spell: Spell) -> void:
	self.spell = spell;
	get_tree().root.remove_child(spell_select)
	pass
