extends VBoxContainer

@export var MageDisplayScene: PackedScene

func set_party(party: Array[Mage]) -> void:
	for child in self.get_children():
		child.queue_free()
	for mage in party:
		var instance = MageDisplayScene.instantiate()
		(instance as MageDisplay).mage = mage
		self.add_child(instance)
