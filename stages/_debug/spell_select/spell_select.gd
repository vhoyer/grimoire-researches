extends CanvasLayer

@onready var spell_display: SpellDisplay = $MarginContainer/PanelContainer/VBoxContainer/SpellDisplay
@onready var spell_list = SpellList.new()
@onready var prefixes: ItemList = %Prefixes
@onready var radixes: ItemList = %Radixes
@onready var postfixes: ItemList = %Postfixes

signal spell_selected;

var pre: = SpellPrepostfix.new():
	set(value):
		pre = value
		spell = spell
var post: = SpellPrepostfix.new():
	set(value):
		post = value
		spell = spell
var radix: = Spell.new():
	set(value):
		radix = value
		spell = spell

var spell: = Spell.new():
	set(value):
		spell = value.duplicate(true);
		spell.pre = pre;
		spell.post = post;
		spell_display.set_values(spell);

func _ready() -> void:
	prefixes.select(2)
	_on_prefixes_item_selected(2)
	radixes.select(0)
	_on_radixes_item_selected(0)
	postfixes.select(0)
	_on_postfixes_item_selected(0)
	pass

func _on_prefixes_item_selected(index: int) -> void:
	pre = spell_list.prefixes[index];

func _on_radixes_item_selected(index: int) -> void:
	spell = spell_list.radixes[index]

func _on_postfixes_item_selected(index: int) -> void:
	post = spell_list.postfixes[index];

func _on_select_spell_button_down() -> void:
	spell_selected.emit(spell)
	pass # Replace with function body.
