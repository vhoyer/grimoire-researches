extends ItemList
class_name ItemListSource

@export var source_list: Array = []:
	set(value):
		source_list = value
		populate_items()
@export var source_label: String

signal source_item_selected(item)

func _init():
	self.item_selected.connect(func(index): source_item_selected.emit(source_list[index]))

func must_use_label() -> bool:
	return source_list.all(func(item): return ![
		TYPE_STRING,
	].has(typeof(item)))

func populate_items() -> void:
	assert(must_use_label() and source_label, 'Error: must use label!')
	self.clear()
	for item in source_list:
		self.add_item(item[source_label] if source_label else item)

func select_item(what) -> void:
	var index = source_list.find(what)
	self.select(index)
	self.item_selected.emit(index)
