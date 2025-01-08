@tool
extends HBoxContainer
class_name MageDisplay

@onready var alter_hp: Button = $AlterHP
@onready var alter_mp: Button = $AlterMP
@onready var alter_name: Button = $AlterName

@export var mage: Mage:
	get(): return mage
	set(value):
		if (mage): mage.updated.disconnect(update_labels)
		mage = value
		mage.updated.connect(update_labels)
		update_labels()
@export var allow_manual_edit: bool = true:
	set(value):
		if alter_hp: alter_hp.set_deferred("visible", value)
		if alter_mp: alter_mp.set_deferred("visible", value)
		allow_manual_edit = value
@export var allow_name_edit: bool = false:
	set(value):
		if alter_name: alter_name.set_deferred("visible", value)
		allow_name_edit = value
@export var prompt: PackedScene

func _ready() -> void:
	allow_manual_edit = allow_manual_edit
	allow_name_edit = allow_name_edit
	if (mage):
		update_labels()

func update_labels() -> void:
	$Label.text = mage.name
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


func _on_alter_name_button_down() -> void:
	var prompt = self.prompt.instantiate()
	get_tree().root.add_child(prompt)
	prompt.value = mage.name
	var cancel = func cancel(): get_tree().root.remove_child(prompt); prompt.queue_free()
	prompt.cancel.connect(cancel)
	prompt.ok.connect(func ok(value): mage.name = value; cancel.call())
