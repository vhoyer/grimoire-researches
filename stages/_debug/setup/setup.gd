extends CanvasLayer

@export var GrimoiresScene: PackedScene

var party_a:= Party.new([
	Mage.new("André", SpellList.generate_grimoire()),
	Mage.new("Doka", SpellList.generate_grimoire()),
	Mage.new("Julio", SpellList.generate_grimoire()),
])

var party_b:= Party.new([
	Mage.new("Tristam", SpellList.generate_grimoire()),
	Mage.new("Gabigol", SpellList.generate_grimoire()),
	Mage.new("Lucas", SpellList.generate_grimoire()),
])

func _ready() -> void:
	party_setup(&'party_a', party_a)
	party_setup(&'party_b', party_b)


func party_setup(side: StringName, party: Party) -> void:
	var set_payload = SceneManager.set_payload.bind(side, party)
	
	party.updated.connect(set_payload)
	SceneManager.set_payload(side, party)
	
	(get_node("%%%s" % [side]) as PartyDisplay).set_party(party)
	(get_node("%%grimoire_%s" % [side]) as Button).button_down.connect(show_grimoires_popup.bind(party))
	
	self.tree_exiting.connect(func(): party.updated.disconnect(set_payload))

func show_grimoires_popup(party: Party) -> void:
	var instance = GrimoiresScene.instantiate()
	SceneManager.singleton.add_child(instance)
	instance.party = party
	instance.close.connect(func(): instance.queue_free())
