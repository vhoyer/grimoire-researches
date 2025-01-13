extends CanvasLayer
@onready var item_list_source: ItemListSource = $MarginContainer/HBoxContainer/ItemListSource

var array = [
	{ 'label': 'dog' },
	{ 'label': 'cat' },
	{ 'label': 'cow' },
	{ 'label': 'ape' },
	{ 'label': 'elk' },
	{ 'label': 'bee' },
	{ 'label': 'fox' },
]

func _ready():
	item_list_source.source_label = 'label'
	item_list_source.source_list = array


func _on_item_list_source_item_activated(index: int) -> void:
	print('activated ', index)


func _on_item_list_source_item_selected(index: int) -> void:
	print('item selected ', index)


func _on_item_list_source_multi_selected(index: int, selected: bool) -> void:
	print('multi selected ', index, selected)
