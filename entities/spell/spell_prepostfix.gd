extends Resource
class_name SpellPrepostfix

@export var name: String = ""
@export var effect: String = ""
@export var turns_casting: SpellModifier = SpellModifier.new()
@export var turns_active: SpellModifier = SpellModifier.new()
@export var mp: SpellModifier = SpellModifier.new()
@export var amount: SpellModifier = SpellModifier.new()
@export var circle: SpellModifier = SpellModifier.new()

@export var chance_primary: SpellModifier = SpellModifier.new()
@export var chance_secondary: SpellModifier = SpellModifier.new()