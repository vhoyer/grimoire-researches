@tool
extends HBoxContainer
class_name HBoxContainerOrderable

@export var is_reversed: bool = false:
	set(value):
		is_reversed = value
		for child in self.get_children():
			self.move_child(child, 0)
