extends CanvasLayer

@export var csv_prepostfix = "res://entities/spell_list/data/prepostfix.csv"
@export var csv_radixes = "res://entities/spell_list/data/spell_radixes.csv"

@export var prefixes_path = "res://entities/spell_list/prefixes/"
@export var postfixes_path = "res://entities/spell_list/postfixes/"
@export var radixes_path = "res://entities/spell_list/radixes/"

var prefixes: Array[SpellPrepostfix] = [];
var radixes: Array[Spell] = [];
var postfixes: Array[SpellPrepostfix] = [];

func load_prepostfixes() -> void:
	var prepost = CSV.new(csv_prepostfix)
	var id = 0
	while (prepost.next()):
		id += 1
		var current = prepost.current;
		var resource_path = "%s/%s-%s.tres" % [
			postfixes_path if current.slot == 'post' else prefixes_path,
			str(id).pad_zeros(3),
			current.name,
		];
		var file_exists = ResourceLoader.exists(resource_path, "SpellPrepostfix")
		var prepostfix: SpellPrepostfix = ResourceLoader.load(resource_path, "SpellPrepostfix") if file_exists else SpellPrepostfix.new()
		prepostfix.id = id
		prepostfix.name = current.name;
		prepostfix.description = current.description;
		prepostfix.turns_casting = SpellModifier.parse(current.turns_casting);
		prepostfix.turns_active = SpellModifier.parse(current.turns_active);
		prepostfix.mp = SpellModifier.parse(current.mp);
		prepostfix.amount = SpellModifier.parse(current.amount);
		prepostfix.circle = SpellModifier.parse(current.circle);
		prepostfix.chance_primary = SpellModifier.parse(current.chance_primary);
		prepostfix.chance_secondary = SpellModifier.parse(current.chance_secondary);
		
		ResourceSaver.save(prepostfix, resource_path)
	prepost.close()

func load_radixes() -> void:
	var radix_list = CSV.new(csv_radixes)
	var id = 0
	while (radix_list.next()):
		id += 1
		var current = radix_list.current;
		var resource_path = "%s/%s-%s.tres" % [radixes_path, str(id).pad_zeros(3), current["spell radix"]];
		var file_exists = ResourceLoader.exists(resource_path, "Spell")
		var spell: Spell = ResourceLoader.load(resource_path, "Spell") if file_exists else Spell.new()
		spell.id = id
		spell.radix = current["spell radix"]
		spell.element = Spell.parse_element(current["element"])
		spell.base_description = current["description"];
		spell.base_mp = current["MP cost"]
		spell.base_amount = current["amount"]
		spell.base_turns_active = current["turns_active"]
		spell.base_chance_primary = float(current["chance_primary"])
		spell.base_chance_secondary = float(current["chance_secondary"])
		
		radixes.push_back(spell)
		ResourceSaver.save(spell, )
	radix_list.close()

func _on_save_resources_from_csv_button_down() -> void:
	load_prepostfixes()
	load_radixes()
	get_tree().quit()


func _on_clear_resource_folders_button_down() -> void:
	clear_dir(postfixes_path)
	clear_dir(prefixes_path)
	clear_dir(radixes_path)

func clear_dir(path: String) -> void:
	var dir = DirAccess.open(path)
	for filepath in dir.get_files():
		dir.remove(filepath)
	
