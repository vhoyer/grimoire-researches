extends PanelContainer

var grimoire = Grimoire.new()

func _ready() -> void:
	update_labels()
	grimoire.updated.connect(update_labels)

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
