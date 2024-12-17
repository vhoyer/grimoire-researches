extends Resource
class_name SpellList

var spells: Array[Spell] = [];

var prefixes: Array[SpellPrepostfix] = [];
var radixes: Array[Spell] = [];
var postfixes: Array[SpellPrepostfix] = [];

func _init() -> void:
	load_prepostfixes()
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

func find_radix(radix: Spell) -> int:
	for i in radixes.size():
		if radixes[i].name == radix.name:
			return i;
	return -1;

func load_prepostfixes() -> void:
	var prepost = CSV.new("res://entities/spell_list/data/prepostfix.csv")
	while (prepost.next()):
		var current = prepost.current;
		var prepostfix = SpellPrepostfix.new();
		prepostfix.name = current.name;
		prepostfix.effect = current.effect;
		prepostfix.turns_casting = SpellModifier.parse(current.turns_casting);
		prepostfix.turns_active = SpellModifier.parse(current.turns_active);
		prepostfix.mp = SpellModifier.parse(current.mp);
		prepostfix.amount = SpellModifier.parse(current.amount);
		prepostfix.circle = SpellModifier.parse(current.circle);
		prepostfix.chance_primary = SpellModifier.parse(current.chance_primary);
		prepostfix.chance_secondary = SpellModifier.parse(current.chance_secondary);
		
		if (current.slot == 'post'):
			postfixes.push_back(prepostfix)
		elif (current.slot == 'pre'):
			prefixes.push_back(prepostfix)
	prepost.close()

func create_spells() -> void:
	var radix_list = CSV.new("res://entities/spell_list/data/spell_radixes.csv")
	while (radix_list.next()):
		var current = radix_list.current;
		var spell = Spell.new();
		spell.radix = current["spell radix"];
		spell.element = Spell.parse_element(current["element"])
		spell.base_effect = current["effect"];
		spell.base_mp = current["MP cost"]
		spell.base_amount = current["amount"]
		spell.base_turns_active = current["turns_active"]
		spell.base_chance_primary = float(current["chance_primary"])
		spell.base_chance_secondary = float(current["chance_secondary"])
		
		radixes.push_back(spell)
		
		for post in postfixes:
			if (current[post.name] != ''): continue;
			var copy = spell.duplicate(true)
			copy.post = post;
			for pre in prefixes:
				if (current[pre.name] != ''): continue;
				var clone = copy.duplicate(true)
				clone.pre = pre;
				spells.push_back(clone)
	radix_list.close()
