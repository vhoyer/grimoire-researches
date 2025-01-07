extends Resource
class_name SpellList

const prefixes_path = "res://entities/spell_list/prefixes/"
const postfixes_path = "res://entities/spell_list/postfixes/"
const radixes_path = "res://entities/spell_list/radixes/"

var spells: Array[Spell] = [];

var prefixes: Array[SpellPrepostfix] = [];
var radixes: Array[SpellRadix] = [];
var postfixes: Array[SpellPrepostfix] = [];

func _init() -> void:
	load_morphenes()
	create_spells()

func find_prefix_by_id(id: int) -> SpellPrepostfix:
	for pre in prefixes:
		if pre.id == id: return pre;
	return null;

func find_postfix_by_id(id: int) -> SpellPrepostfix:
	for post in postfixes:
		if post.id == id: return post;
	return null;

func find_radix_by_id(id: int) -> SpellRadix:
	for radix in radixes:
		if radix.id == id: return radix;
	return null;

func load_morphenes() -> void:
	load_one_morphene(prefixes_path, prefixes)
	load_one_morphene(postfixes_path, postfixes)
	load_one_morphene(radixes_path, radixes)

func load_one_morphene(path: String, collection: Array) -> void:
	var dir = DirAccess.open(path)
	for filepath in dir.get_files():
		collection.push_back(load(path.path_join(filepath.replace(".remap", ""))))

func create_spells() -> void:
	for radix in radixes:
		var spell = Spell.new()
		spell.radix = radix
		for post in postfixes:
			if not radix.constraints[post.name]: continue;
			spell.post = post;
			for pre in prefixes:
				if not radix.constraints[pre.name]: continue;
				var clone = spell.duplicate(true)
				clone.pre = pre;
				spells.push_back(clone)
