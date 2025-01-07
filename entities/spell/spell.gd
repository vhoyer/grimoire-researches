extends Resource
class_name Spell

enum Elements {
	fire = 0,
	water = 1,
	earth = 2,
	wind = 3,
	light = 4,
	dark = 5,
}

static func parse_element(raw: String) -> Elements:
	assert(Elements.has(raw), "Error: raw element cannot be parsed");
	return Elements.get(raw);

@export var id: int = 0

@export var pre: SpellPrepostfix = SpellPrepostfix.new()
@export var post: SpellPrepostfix = SpellPrepostfix.new()
@export var radix: SpellRadix = SpellRadix.new()

var name: String:
	get(): return pre.name.replace('(nil)', '') + radix.name + post.name;
var description: String:
	get():
		return String('\n').join([
			radix.description
			.replace('{turns_active}', str(turns_active))
			.replace('{chance_secondary}', pcent(chance_secondary))
			.replace('{chance_primary}', pcent(chance_primary))
			.replace('{amount}', str(amount)),
			pre.description,
		])

var element: Elements:
	get(): return radix.element
var mp: int:
	get(): return ceil(modify('mp'))
var turns_casting: int:
	get(): return ceil(modify('turns_casting'))
var turns_active: int:
	get(): return ceil(modify('turns_active'))
var circle: int:
	get(): return ceil(modify('circle'))
var amount: int:
	get(): return ceil(modify('amount'))
var chance_primary: float:
	get(): return max(0.0, min(1.0, modify('chance_primary')))
var chance_secondary: float:
	get(): return max(0.0, min(1.0, modify('chance_secondary')))
var is_passive: bool:
	get(): return pre.is_passive
var is_initial: bool:
	get(): return pre.is_initial
var is_castable: bool:
	get(): return !pre.is_initial and !pre.is_passive
var targets: int:
	get(): return max(0, min(3, modify('targets')))

func modify(what: String) -> float:
	return pre[what].mod(post[what].mod(radix[what]));

func pcent(raw: float) -> String:
	var value = floor(raw * 100)
	return str(value) + '%'

func charge_cost(caster: Mage):
	caster.mp -= caster.statuses.process('spell_cost_modifier', [mp])

func do_effect(action: BattleAction) -> void:
	for effect in radix.effect:
		effect.do_effect(action)

func revert_effect(action: BattleAction) -> void:
	for effect in radix.effect:
		effect.revert_effect(action)

func turn_effect(action: BattleAction) -> void:
	for effect in radix.effect:
		effect.turn_effect(action)
