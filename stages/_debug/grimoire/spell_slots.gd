extends VBoxContainer

@export var SpellSlotScene: PackedScene;

func _ready() -> void:
	var grimoire = %Book.grimoire
	for index in grimoire.SIZE:
		var btn = SpellSlotScene.instantiate()
		btn.grimoire = grimoire
		btn.slot_index = index
		self.add_child(btn)
