class_name Util

static func find_custom(arr: Array, finder: Callable, start_at: int = 0) -> int:
	for index in arr.slice(start_at).size():
		var item = arr[index]
		if finder.call(item):
			return index
	
	return -1
