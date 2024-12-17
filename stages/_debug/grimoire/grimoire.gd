extends PanelContainer

@export var SpellSlotScene: PackedScene;
@onready var page_right: VBoxContainer = $BookPages/PageRight

var grimoire: Grimoire

signal grimoire_changed;

func change_grimoire(grimoire: Grimoire) -> void:
	if (self.grimoire != null and self.grimoire.updated.is_connected(update_labels)):
		self.grimoire.updated.disconnect(update_labels)
	self.grimoire = grimoire
	self.grimoire.updated.connect(update_labels)
	update_labels()
	call_deferred('update_slots')
	grimoire_changed.emit(self.grimoire)

func update_labels():
	%Fire.text = str(grimoire.affinities.fire);
	%Water.text = str(grimoire.affinities.water);
	%Earth.text = str(grimoire.affinities.earth);
	%Wind.text = str(grimoire.affinities.wind);
	%Light.text = str(grimoire.affinities.light);
	%Dark.text = str(grimoire.affinities.dark);

	%Power.text = str(grimoire.stats.power);
	%Vitality.text = str(grimoire.stats.vitality);
	%Endurance.text = str(grimoire.stats.endurance);
	%Agility.text = str(grimoire.stats.agility);
	%Luck.text = str(grimoire.stats.luck);
	%Energy.text = str(grimoire.stats.energy);

	%HP.text = str(grimoire.stats.max_hp);
	%MP.text = str(grimoire.stats.max_mp);

func update_slots() -> void:
	for child in page_right.get_children():
		child.free();
	for index in grimoire.SIZE:
		var btn = SpellSlotScene.instantiate()
		btn.grimoire = grimoire
		btn.slot_index = index
		page_right.add_child(btn)
