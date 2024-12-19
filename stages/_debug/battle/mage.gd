extends HBoxContainer

@export var mage: Mage = Mage.new("Dummy")
@export var prompt: PackedScene

func _ready() -> void:
	update_labels()
	mage.updated.connect(update_labels)

func update_labels() -> void:
	$HPMP.text = """
	HP: %d
	MP: %d
	""" % [mage.hp, mage.mp]

func _on_alter_hp_button_down() -> void:
	var prompt = self.prompt.instantiate()
	get_tree().root.add_child(prompt)
	prompt.value = str(mage.hp)
	var cancel = func cancel(): get_tree().root.remove_child(prompt); prompt.queue_free()
	prompt.cancel.connect(cancel)
	prompt.ok.connect(func ok(value): print(mage.hp);mage.hp = int(value); cancel.call())


func _on_alter_mp_button_down() -> void:
	var prompt = self.prompt.instantiate()
	get_tree().root.add_child(prompt)
	prompt.value = str(mage.mp)
	var cancel = func cancel(): get_tree().root.remove_child(prompt); prompt.queue_free()
	prompt.cancel.connect(cancel)
	prompt.ok.connect(func ok(value): mage.mp = int(value); cancel.call())
