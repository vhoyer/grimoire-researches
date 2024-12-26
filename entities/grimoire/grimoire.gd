extends Resource
class_name Grimoire

const SIZE := 10

var _list: Array[Spell] = []

var affinities:= Affinities.new();
var stats:= Stats.new();

var hash: String:
	get():
		var prehash = []
		prehash.resize(SIZE)
		for index in SIZE:
			var spell = _list[index]
			prehash[index] = [] if spell == null else [spell.pre.id, spell.radix.id, spell.post.id]
		return Marshalls.variant_to_base64(prehash, true)

signal updated;

func _init() -> void:
	_list.resize(SIZE)
	pass

func set_spell(idx: int, spell: Spell) -> void:
	_list[idx] = spell;
	recalculate();
	pass
	
func get_spell(idx: int) -> Spell:
	return _list[idx];

func recalculate() -> void:
	affinities = Affinities.new();
	for spell in _list:
		if spell == null: continue;
		affinities.process_spell(spell);
		if (spell.is_passive):
			for effect in spell.radix.effect:
				var dummy_mage = Mage.new("dummy", self)
				effect.do_effect(spell, dummy_mage, [dummy_mage])
		
	updated.emit();

func load_hash(hash: String) -> void:
	var posthash = Marshalls.base64_to_variant(hash, true)
	var spell_list = SpellList.new()
	for i in SIZE:
		if (posthash[i] == []): continue
		var code = posthash[i] as Array[int]
		var id_pre = code.pop_front()
		var id_radix = code.pop_front()
		var id_post = code.pop_front()
		var spell: Spell = Spell.new()
		spell.pre = spell_list.find_prefix_by_id(id_pre)
		spell.radix = spell_list.find_radix_by_id(id_radix)
		spell.post = spell_list.find_postfix_by_id(id_post)
		set_spell(i, spell)
