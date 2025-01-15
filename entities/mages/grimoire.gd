extends Resource
class_name Grimoire

const SIZE := 10

var _list: Array[Spell] = []
var spells: Array[Spell]:
	get(): return _list.filter(func(item): return item != null);

var affinities:= Affinities.new();
var stats:= Stats.new();

var hash: String:
	get():
		var prehash = []
		prehash.resize(SIZE)
		for index in SIZE:
			var spell = _list[index]
			prehash[index] = [] if spell == null else [spell.pre.id, spell.radix.id, spell.post.id]
		return JSON.stringify(prehash)

var mp_per_turn: int = 0

signal updated;

func _init(hash: String = "") -> void:
	_list.resize(SIZE)
	if hash: load_hash(hash)

func set_spell(idx: int, spell: Spell) -> void:
	_list[idx] = spell;
	recalculate();
	
func get_spell(idx: int) -> Spell:
	return _list[idx];

func recalculate() -> void:
	affinities = Affinities.new()
	stats = Stats.new()
	mp_per_turn = 0
	
	for spell in _list:
		if spell == null: continue;
		affinities.process_spell(spell);
		if (spell.is_passive):
			mp_per_turn += spell.mp
			for effect in spell.radix.effect:
				apply_spell_effect_onto_grimoire(effect, spell)
	
	updated.emit()

func apply_spell_effect_onto_grimoire(effect: SpellEffect, spell: Spell) -> void:
	var dummy_mage = Mage.new("dummy", self)
	effect.do_effect(BattleAction.new(spell, dummy_mage, [dummy_mage]))
	stats = dummy_mage.stats
	affinities = dummy_mage.affinities


func load_hash(hash: String) -> void:
	var posthash = JSON.parse_string(hash)
	if posthash == null:
		self.hash = self.hash
		return
	
	if posthash is Array:
		posthash.resize(SIZE)
	
	for i in SIZE:
		if (posthash[i] == null or posthash[i] == []):
			set_spell(i, null)
			continue
		var code = posthash[i] as Array[int]
		var id_pre = code.pop_front()
		var id_radix = code.pop_front()
		var id_post = code.pop_front()
		var spell: Spell = Spell.new()
		spell.pre = SpellList.find_prefix_by_id(id_pre)
		spell.radix = SpellList.find_radix_by_id(id_radix)
		spell.post = SpellList.find_postfix_by_id(id_post)
		set_spell(i, spell)
