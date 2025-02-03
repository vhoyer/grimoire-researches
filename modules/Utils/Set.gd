class_name Set

var _elements: Array = []

func add(value: Variant) -> void:
	if _elements.has(value): return
	_elements.append(value)

func has(value: Variant) -> bool:
	return _elements.has(value)

func has_all(arr: Array[Variant]) -> bool:
	return arr.all(func(item): return self.has(item))

func erase_all() -> void:
	_elements.resize(0)
