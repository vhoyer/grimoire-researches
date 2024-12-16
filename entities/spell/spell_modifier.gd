extends Resource
class_name SpellModifier

enum Type {
	add,
	set,
	multiply,
}

@export var type : Type = Type.multiply
@export var value : float = 1

static func parse(raw: String) -> SpellModifier:
	var mod = SpellModifier.new();
	mod.value = float(raw.substr(1));
	
	var operation = raw.substr(0, 1);
	match operation:
		'+', '-':
			mod.type = Type.add;
		'*', '/':
			mod.type = Type.multiply;
		'=':
			mod.type = Type.set;
	match operation:
		'-': mod.value *= -1;
		'/': mod.value = 1 / mod.value;
	
	return mod;

func mod(v: float) -> float:
	if (type == Type.add):
		return v + value;
	if (type == Type.set):
		return value;
	return v * value;
