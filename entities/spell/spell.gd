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

@export var pre: SpellPrepostfix = SpellPrepostfix.new()
@export var post: SpellPrepostfix = SpellPrepostfix.new()

@export var radix: String
@export var base_description: String
@export var element: Elements

@export var base_mp: int = 12
@export var base_amount: int = 1
@export var base_turns_active: int = 1
@export var base_chance_primary: float = 1.0/3
@export var base_chance_secondary: float = 1.0/6
# implict values (could be const, should be const, but I'm insane)
@export var base_circle: int = 1
@export var base_turns_casting: int = 1


var name: String:
	get(): return pre.name.replace('(nil)', '') + radix + post.name;
var description: String:
	get():
		return String('\n').join([
			base_description
			.replace('{turns_active}', str(turns_active))
			.replace('{chance_secondary}', pcent(chance_secondary))
			.replace('{chance_primary}', pcent(chance_primary))
			.replace('{amount}', str(amount)),
			pre.description,
		])

var mp: int:
	get(): return ceil(modify('mp', base_mp))
var turns_casting: int:
	get(): return ceil(modify('turns_casting', base_turns_casting))
var turns_active: int:
	get(): return ceil(modify('turns_active', base_turns_active))
var circle: int:
	get(): return ceil(modify('circle', base_circle))
var amount: int:
	get(): return ceil(modify('amount', base_amount))
var chance_primary: float:
	get(): return max(0.0, min(1.0, modify('chance_primary', base_chance_primary)))
var chance_secondary: float:
	get(): return max(0.0, min(1.0, modify('chance_secondary', base_chance_secondary)))

func modify(what: String, value: float) -> float:
	return pre[what].mod(post[what].mod(value));

func pcent(raw: float) -> String:
	var value = floor(raw * 100)
	return str(value) + '%'

func extract_radix() -> Spell:
	var radix = self.duplicate(true)
	radix.pre = SpellPrepostfix.new()
	radix.post = SpellPrepostfix.new()
	return radix
