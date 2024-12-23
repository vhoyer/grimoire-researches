extends ItemList
class_name ItemListSource

@export var source_label: String
@export var source_list: Array = []:
	set(value):
		source_list = value
		populate_items()

## if this callable returns true when re-populating the source list, automatically selects that item
var source_is_default: Callable = func(item): return false

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
	self.source_is_default
	var default_item = source_list[0] if source_list.size() > 0 else null
	for item in source_list:
		self.add_item(item[source_label] if source_label else item)
		if (source_is_default.call(item)):
			default_item = item
	
	if (default_item):
		self.select_item(default_item)

func select_item(what: Variant) -> void:
	var index = source_list.find(what)
	self.select(index)
	self.item_selected.emit(index)
