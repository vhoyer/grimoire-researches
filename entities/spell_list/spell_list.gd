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
	load_morphemes()
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

func load_morphemes() -> void:
	var prefixes_dir = DirAccess.open(prefixes_path)
	for filepath in prefixes_dir.get_files():
		prefixes.push_back(ResourceLoader.load(prefixes_path + filepath))
	
	var postfixes_dir = DirAccess.open(postfixes_path)
	for filepath in postfixes_dir.get_files():
		postfixes.push_back(ResourceLoader.load(postfixes_path + filepath))
	
	var radixes_dir = DirAccess.open(radixes_path)
	for filepath in radixes_dir.get_files():
		radixes.push_back(ResourceLoader.load(radixes_path + filepath))

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
