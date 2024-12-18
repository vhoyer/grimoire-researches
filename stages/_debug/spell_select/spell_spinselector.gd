@tool
extends HBoxContainer

@onready var prefixes: ItemList = $Prefixes
@onready var radixes: ItemList = $Radixes
@onready var postfixes: ItemList = $Postfixes

@export var reload := false :
	set(value):
		loadparts(SpellList.new())
		reload = value;

func loadparts(spell_list: SpellList) -> void:
	one_list(prefixes, spell_list.prefixes)
	one_list(radixes, spell_list.radixes)
	one_list(postfixes, spell_list.postfixes)

func one_list(it: ItemList, spl: Array):
	it.clear()
	for item in spl:
		it.add_item(item.name.replace('(nil)', '-'))
