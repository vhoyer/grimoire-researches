extends CanvasLayer

@onready var spell_display: SpellDisplay = $MarginContainer/PanelContainer/VBoxContainer/SpellDisplay
@onready var spell_list = SpellList.new()
@onready var prefixes: ItemListSource = %Prefixes
@onready var radixes: ItemListSource = %Radixes
@onready var postfixes: ItemListSource = %Postfixes

signal spell_selected;
signal cancel;

var pre:= SpellPrepostfix.new():
	set(value):
		pre = value
		spell = spell
var post:= SpellPrepostfix.new():
	set(value):
		post = value
		spell = spell
var radix:= SpellRadix.new():
	set(value):
		radix = value
		load_one_list(prefixes, spell_list.prefixes, radix.constraints)
		load_one_list(postfixes, spell_list.postfixes, radix.constraints)
		spell = spell

var spell:= Spell.new():
	set(value):
		spell = value.duplicate(true);
		spell.pre = pre;
		spell.post = post;
		spell.radix = radix;
		spell_display.set_values(spell);

func _ready() -> void:
	load_morphene_lists()

func select_spell(spell: Spell) -> void:
	if (spell == null): return

	radixes.select_item(spell.radix)
	prefixes.select_item(spell.pre)
	postfixes.select_item(spell.post)

func load_one_list(it: ItemListSource, morphene: Array, constraints: Dictionary):
	var filter = func(item):
		return constraints[item.name]
	
	it.source_is_default = func(item): return item.is_default
	it.source_list = morphene if constraints.is_empty() else morphene.filter(filter)

func load_morphene_lists() -> void:
	load_one_list(prefixes, spell_list.prefixes, radix.constraints)
	load_one_list(postfixes, spell_list.postfixes, radix.constraints)
	radixes.source_list = spell_list.radixes

func _on_select_spell_button_down() -> void:
	spell_selected.emit(spell)

func _on_cancel_button_down() -> void:
	cancel.emit()

func _on_prefixes_source_item_selected(item: Variant) -> void:
	pre = item

func _on_radixes_source_item_selected(item: Variant) -> void:
	radix = item

func _on_postfixes_source_item_selected(item: Variant) -> void:
	post = item
