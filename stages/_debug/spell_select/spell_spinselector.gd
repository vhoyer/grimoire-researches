@tool
extends HBoxContainer

@onready var prefixes: ItemListSource = $Prefixes
@onready var radixes: ItemListSource = $Radixes
@onready var postfixes: ItemListSource = $Postfixes
@onready var spell_select: CanvasLayer = $"../../../.."

@export var reload := false :
	set(value):
		loadparts(SpellList.new())
		reload = value;

func loadparts(spell_list: SpellList) -> void:
	prefixes.source_list = spell_list.prefixes
	postfixes.source_list = spell_list.postfixes
	radixes.source_list = spell_list.radixes
