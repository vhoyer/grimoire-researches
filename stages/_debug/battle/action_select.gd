extends PanelContainer

@onready var action_list: ItemListSource = $HBoxContainer/ActionList
@onready var spell_display: SpellDisplay = $HBoxContainer/SpellDisplay

signal action_selected(action: BattleAction)


func setup(combatant: Mage) -> void:
	action_list.source_list = combatant.get_action_list()


func _on_action_list_source_item_selected(action: BattleAction) -> void:
	spell_display.set_values(action.spell)


func _on_action_list_source_item_actived(action: BattleAction) -> void:
	action_selected.emit(action)
