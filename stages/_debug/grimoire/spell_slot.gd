extends Button

@export var SpellSelectionScene: PackedScene;
var spell_select;
var spell: Spell:
	set(value):
		if value == null:
			self.text = '+'
			return
		self.text = value.name
		spell = value

func _on_button_down() -> void:
	spell_select = SpellSelectionScene.instantiate()
	get_tree().root.add_child(spell_select)
	spell_select.connect('spell_selected', _on_spell_selected);

func _on_spell_selected(spell: Spell) -> void:
	self.spell = spell;
	get_tree().root.remove_child(spell_select)
	pass
