extends PanelContainer

@onready var action_list: ItemListSource = $HBoxContainer/ActionList
@onready var spell_display: SpellDisplay = $HBoxContainer/SpellDisplay
@onready var target_list: ItemListSource = $HBoxContainer/TargetList

signal action_selected(action: BattleAction)

var current_action: BattleAction


func _ready() -> void:
	action_list.source_is_disabled = func(action: BattleAction):
		if action.type == BattleAction.Type.magic:
			return !action.caster.can_cast_spell(action.spell)
		return false

func setup(combatant: Mage) -> void:
	action_list.source_list = combatant.get_action_list()
	target_list.visible = false


func _on_action_list_source_item_selected(action: BattleAction) -> void:
	spell_display.set_values(action.spell)
	target_list.visible = false


func _on_action_list_source_item_actived(action: BattleAction) -> void:
	if !action.targets.is_empty():
		action_selected.emit(action)
		return
	target_list.visible = true
	target_list.source_list = BattleManager.instance.combatants
	current_action = action


func _on_target_list_source_multi_selected(targets_selected: Array) -> void:
	if current_action == null: return
	var max_targets = current_action.spell.targets
	if targets_selected.size() < max_targets: return
	
	var targets: Array[Mage] = []
	targets.append_array(targets_selected)
	current_action.targets = targets
	
	action_selected.emit(current_action)
	current_action = null
