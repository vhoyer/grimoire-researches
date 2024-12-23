extends CanvasLayer

@onready var spell_display: SpellDisplay = $MarginContainer/PanelContainer/VBoxContainer/SpellDisplay
@onready var spell_list = SpellList.new()
@onready var prefixes: ItemList = %Prefixes
@onready var radixes: ItemList = %Radixes
@onready var postfixes: ItemList = %Postfixes

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
	prefixes.select(2)
	_on_prefixes_item_selected(2)
	radixes.select(0)
	_on_radixes_item_selected(0)
	postfixes.select(0)
	_on_postfixes_item_selected(0)

func select_spell(spell: Spell) -> void:
	if (spell == null): return

	select_and_emit(prefixes, spell_list.find_prefix(spell.pre))
	select_and_emit(postfixes, spell_list.find_postfix(spell.post))
	select_and_emit(radixes, spell_list.find_radix(spell.radix))

func select_and_emit(item_list: ItemList, index: int) -> void:
	item_list.select(index)
	item_list.item_selected.emit(index)

func load_one_list(it: ItemListSource, morphene: Array, constraints: Dictionary):
	it.source_list = morphene.map(func(item):
		item.name = item.name.replace('(nil)', '-')
		return item
		)

func load_morphene_lists() -> void:
	load_one_list(prefixes, spell_list.prefixes, radix.constraints)
	load_one_list(postfixes, spell_list.postfixes, radix.constraints)
	load_one_list(radixes, spell_list.radixes, {})

func _on_prefixes_item_selected(index: int) -> void:
	pre = spell_list.prefixes[index];

func _on_radixes_item_selected(index: int) -> void:
	radix = spell_list.radixes[index]

func _on_postfixes_item_selected(index: int) -> void:
	post = spell_list.postfixes[index];

func _on_select_spell_button_down() -> void:
	spell_selected.emit(spell)

func _on_cancel_button_down() -> void:
	cancel.emit()
