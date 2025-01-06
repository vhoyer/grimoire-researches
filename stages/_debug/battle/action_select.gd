extends PanelContainer

@onready var action_list: ItemListSource = $HBoxContainer/ActionList
@onready var spell_display: SpellDisplay = $HBoxContainer/SpellDisplay

signal action_selected(action: BattleAction)

var caster:= Mage.new()

func setup(member: Mage) -> void:
	caster = member
	action_list.source_list = member.grimoire.spells


func _on_action_list_source_item_selected(spell: Spell) -> void:
	spell_display.set_values(spell)


func _on_action_list_source_item_actived(spell: Spell) -> void:
	var action = BattleAction.new(spell, caster)
	action_selected.emit(action)
