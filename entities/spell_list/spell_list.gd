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

func find_prefix(prefix: SpellPrepostfix) -> int:
	for i in prefixes.size():
		if prefixes[i].name == prefix.name:
			return i;
	return -1;

func find_postfix(postfix: SpellPrepostfix) -> int:
	for i in postfixes.size():
		if postfixes[i].name == postfix.name:
			return i;
	return -1;

func find_radix(radix: SpellRadix) -> int:
	for i in radixes.size():
		if radixes[i].name == radix.name:
			return i;
	return -1;

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
	
	for rad in radixes: print(rad.name)

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
