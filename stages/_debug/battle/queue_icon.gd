@tool
extends PanelContainer

@export var mage: Mage = Mage.new():
	set(value):
		if (mage and mage.updated.is_connected(update_labels)):
			mage.updated.disconnect(update_labels)
		mage = value
		mage.updated.connect(update_labels)
		update_labels()

@export var is_current: bool = false:
	set(value):
		is_current = value
		if is_current:
			var active = self.get_theme_stylebox("active", self.theme_type_variation)
			self.add_theme_stylebox_override("panel", active)
		else:
			self.remove_theme_stylebox_override("panel")

func _ready() -> void:
	update_labels()


func update_labels():
	$Label.text = mage.name
