extends Resource
class_name SpellList

const PREFIXES_PATH = "res://entities/spell_list/prefixes/"
const POSTFIXES_PATH = "res://entities/spell_list/postfixes/"
const RADIXES_PATH = "res://entities/spell_list/radixes/"

static var all: Array[Spell]:
	get():
		if all: return all
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
					all.push_back(clone)
		all.make_read_only()
		return all

static var prefixes: Array[SpellPrepostfix]:
	get():
		if prefixes: return prefixes
		load_one_morphene(PREFIXES_PATH, prefixes)
		prefixes.make_read_only()
		return prefixes

static var postfixes: Array[SpellPrepostfix]:
	get():
		if postfixes: return postfixes
		load_one_morphene(POSTFIXES_PATH, postfixes)
		postfixes.make_read_only()
		return postfixes

static var radixes: Array[SpellRadix]:
	get():
		if radixes: return radixes
		load_one_morphene(RADIXES_PATH, radixes)
		radixes.make_read_only()
		return radixes


static func load_one_morphene(path: String, collection: Array) -> void:
	var dir = DirAccess.open(path)
	for filepath in dir.get_files():
		collection.push_back(load(path.path_join(filepath.replace(".remap", ""))))


static func find_prefix_by_id(id: int) -> SpellPrepostfix:
	for pre in prefixes:
		if pre.id == id: return pre;
	return null;

static func find_postfix_by_id(id: int) -> SpellPrepostfix:
	for post in postfixes:
		if post.id == id: return post;
	return null;

static func find_radix_by_id(id: int) -> SpellRadix:
	for radix in radixes:
		if radix.id == id: return radix;
	return null;

static func generate_grimoire() -> Grimoire:
	var grimoire = Grimoire.new()
	var spells = all.duplicate()
	spells.shuffle()
	var list = spells.slice(0, grimoire.SIZE)
	for index in grimoire.SIZE:
		grimoire.set_spell(index, list[index])
	return grimoire
