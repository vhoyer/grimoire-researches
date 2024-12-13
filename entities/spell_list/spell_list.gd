extends Resource
class_name SpellList

var spells: Array[Spell] = [];

var prefixes: Array[SpellPrepostfix] = [];
var postfixes: Array[SpellPrepostfix] = [];

func _init() -> void:
	load_prepostfixes()
	create_spells()

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
	var radixes = CSV.new("res://entities/spell_list/data/spell_radixes.csv")
	while (radixes.next()):
		var current = radixes.current;
		var spell = Spell.new();
		spell.radix = current["spell radix"];
		spell.element = Spell.parse_element(current["element"])
		spell.base_effect = current["effect"];
		spell.base_mp = current["MP cost"]
		spell.base_amount = current["amount"]
		spell.base_turns_active = current["turns_active"]
		spell.base_chance_primary = float(current["chance_primary"])
		spell.base_chance_secondary = float(current["chance_secondary"])
		
		for post in postfixes:
			if (current[post.name] != ''): continue;
			var copy = spell.duplicate(true)
			copy.post = post;
			spells.push_back(copy);
			for pre in prefixes:
				if (current[pre.name] != ''): continue;
				var clone = copy.duplicate(true)
				clone.pre = pre;
				spells.push_back(clone)
	radixes.close()
