extends CanvasLayer

var dict = {
	'a': [1, 'a'],
	'b': [2, 'b'],
	'c': [3, 'c'],
	'd': [4, 'd'],
	'e': [5, 'e'],
	'f': [6, 'f'],
	'g': [7, 'g'],
}

var _dict:
	get(): return dict

func _on_button_button_down() -> void:
	print(_dict)
	_dict = {}
	print(_dict)
