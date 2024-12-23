extends CanvasLayer

@export var GrimoiresScene: PackedScene

var party_left: Array[Mage] = [
	Mage.new("André"),
	Mage.new("Doka"),
	Mage.new("Julio"),
]

var party_right: Array[Mage] = [
	Mage.new("Tristam"),
	Mage.new("Patrick"),
	Mage.new("Lucas"),
]

@onready var party_a: VBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer/PartyA
@onready var party_b: VBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer/PartyB

func _ready() -> void:
	party_a.set_party(party_left)
	party_b.set_party(party_right)

func show_grimoires_popup(party: Array[Mage]) -> void:
	var instance = GrimoiresScene.instantiate()
	get_tree().root.add_child(instance)
	instance.party = party
	instance.close.connect(func(): instance.queue_free())

func _on_grimoire_left_button_down() -> void:
	show_grimoires_popup(party_left)

func _on_grimoire_right_button_down() -> void:
	show_grimoires_popup(party_right)
