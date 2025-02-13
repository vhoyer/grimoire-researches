extends CanvasLayer

@export var csv_prepostfix = "res://entities/spell_list/data/prepostfix.csv"
@export var csv_radixes = "res://entities/spell_list/data/spell_radixes.csv"

var prepostfixes: Array[SpellPrepostfix] = []

func load_prepostfixes() -> void:
	var prepost = CSV.new(csv_prepostfix)
	var id = 0
	while (prepost.next()):
		id += 1
		var current = prepost.current
		var resource_path = "%s/%s-%s.tres" % [
			SpellList.POSTFIXES_PATH if current.slot == 'post' else SpellList.PREFIXES_PATH,
			str(id).pad_zeros(3),
			current.name,
		]
		var file_exists = ResourceLoader.exists(resource_path, "SpellPrepostfix")
		var prepostfix: SpellPrepostfix = ResourceLoader.load(resource_path, "SpellPrepostfix") if file_exists else SpellPrepostfix.new()
		prepostfix.id = id
		prepostfix.name = current.name
		prepostfix.description = current.description
		prepostfix.turns_casting = SpellModifier.parse(current.turns_casting)
		prepostfix.turns_active = SpellModifier.parse(current.turns_active)
		prepostfix.mp = SpellModifier.parse(current.mp)
		prepostfix.amount = SpellModifier.parse(current.amount)
		prepostfix.circle = SpellModifier.parse(current.circle)
		prepostfix.chance_primary = SpellModifier.parse(current.chance_primary)
		prepostfix.chance_secondary = SpellModifier.parse(current.chance_secondary)
		prepostfix.is_passive = str(current.effect).contains('passive')
		prepostfix.is_initial = str(current.effect).contains('initial')
		prepostfix.is_default = str(current.effect).contains('default')
		prepostfix.targets = SpellModifier.parse(current['targets'])

		ResourceSaver.save(prepostfix, resource_path)
		prepostfixes.push_back(prepostfix)
	prepost.close()

func load_radixes() -> void:
	var radix_list = CSV.new(csv_radixes)
	var id = 0
	while (radix_list.next()):
		id += 1
		var current = radix_list.current;
		var resource_path = "%s/%s-%s.tres" % [SpellList.RADIXES_PATH, str(id).pad_zeros(3), current["spell radix"]];
		var file_exists = ResourceLoader.exists(resource_path, "SpellRadix")
		var radix: SpellRadix = ResourceLoader.load(resource_path, "SpellRadix") if file_exists else SpellRadix.new()
		radix.id = id
		radix.name = current["spell radix"]
		radix.element = Spell.parse_element(current["element"])
		radix.description = current["description"];
		radix.mp = current["MP cost"]
		radix.amount = current["amount"]
		radix.turns_active = current["turns_active"]
		radix.chance_primary = float(current["chance_primary"])
		radix.chance_secondary = float(current["chance_secondary"])
		radix.targets = current["targets"]

		radix.constraints = {}
		for prepost in prepostfixes:
			radix.constraints[prepost.name] = (current[prepost.name] == '')

		ResourceSaver.save(radix, resource_path)
	radix_list.close()

func _on_save_resources_from_csv_button_down() -> void:
	load_prepostfixes()
	load_radixes()
	get_tree().quit()


func _on_clear_resource_folders_button_down() -> void:
	clear_dir(SpellList.POSTFIXES_PATH)
	clear_dir(SpellList.PREFIXES_PATH)
	clear_dir(SpellList.RADIXES_PATH)

func clear_dir(path: String) -> void:
	var dir = DirAccess.open(path)
	for filepath in dir.get_files():
		dir.remove(filepath)
