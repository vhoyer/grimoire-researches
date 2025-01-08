@tool
extends VBoxContainer
class_name PartyDisplay

@onready var hash_holder: PanelContainer = $HashHolder

@export var MageDisplayScene: PackedScene
@export var display_hash: bool = false:
	set(value):
		display_hash = value
		if hash_holder: hash_holder.visible = value

var party: Party:
	set(value):
		if (party and party.updated.is_connected(update_labels)):
			party.updated.disconnect(update_labels)
		party = value
		party.updated.connect(update_labels)
		update_labels()


func _ready() -> void:
	display_hash = display_hash


func set_party(party: Party) -> void:
	self.party = party

func update_labels() -> void:
	var holder = $MageHolder
	for index in party.members.size():
		var mage = party.members[index]
		var display = holder.get_child(index) as MageDisplay
		display.mage = mage
	update_hash()


func update_hash() -> void:
	%Hash.text = party.hash
	$HashHolder/VBoxContainer/Label2.text = str(party.hash.length())


func _on_hash_text_changed(new_text: String) -> void:
	party.load_hash(new_text)
