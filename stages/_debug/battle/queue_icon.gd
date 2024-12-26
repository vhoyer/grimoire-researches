@tool
extends PanelContainer

@export var mage: Mage = Mage.new():
	set(value):
		if (mage and mage.updated.is_connected(update_labels)):
			mage.updated.disconnect(update_labels)
		mage = value
		mage.updated.connect(update_labels)
		update_labels()

func _ready() -> void:
	update_labels()


func update_labels():
	$Label.text = mage.name
