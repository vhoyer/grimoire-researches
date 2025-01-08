extends VBoxContainer

@export var MageDisplayScene: PackedScene

func set_party(party: Party) -> void:
	for child in self.get_children():
		child.queue_free()
	for mage in party.members:
		var instance = MageDisplayScene.instantiate()
		(instance as MageDisplay).mage = mage
		self.add_child(instance)
