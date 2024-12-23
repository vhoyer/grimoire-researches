extends CanvasLayer

@onready var item_list_source: ItemListSource = $MarginContainer/HBoxContainer/ItemListSource
@onready var label: Label = $MarginContainer/HBoxContainer/Label
var arr = [
	{ 'id': 0, 'title': 'a' },
	{ 'id': 1, 'title': 'b' },
	{ 'id': 2, 'title': 'a' },
	{ 'id': 3, 'title': 'c' },
	{ 'id': 4, 'title': 'a' },
	{ 'id': 5, 'title': 't' },
	{ 'id': 6, 'title': 'e' },
]

func _ready() -> void:
	item_list_source.source_label = 'title'

func _on_button_button_down() -> void:
	item_list_source.source_list = arr;


func _on_item_list_source_source_item_selected(item) -> void:
	print(item)
	label.text = item.title
