@tool
extends HBoxContainer

@onready var prefixes: ItemListSource = $Prefixes
@onready var radixes: ItemListSource = $Radixes
@onready var postfixes: ItemListSource = $Postfixes
@onready var spell_select: CanvasLayer = $"../../../.."

@export var reload := false :
	set(value):
		loadparts()
		reload = value;

func loadparts() -> void:
	prefixes.source_list = SpellList.prefixes
	postfixes.source_list = SpellList.postfixes
	radixes.source_list = SpellList.radixes
