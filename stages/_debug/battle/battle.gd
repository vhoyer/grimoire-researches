extends CanvasLayer

@export var GrimoiresScene: PackedScene

@export var manager: BattleManager

@onready var party_a: VBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer/PartyA
@onready var party_b: VBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer/PartyB
@onready var queue: HBoxContainer = %Queue

func _ready() -> void:
	manager = BattleManager.new(
		SceneManager.get_payload(&'party_a'),
		SceneManager.get_payload(&'party_b'),
	)
	party_a.set_party(manager.party_a)
	party_b.set_party(manager.party_b)
	queue.init_queue(manager.queue)

	manager.turn_started.connect(start_turn)
	%ActionSelect.action_selected.connect(manager.turn_act)
	call_deferred('start_turn', manager.queue.current)

func start_turn(combatant: Mage) -> void:
	%ActionSelect.setup(combatant)

func show_grimoires_popup(party: Party) -> void:
	var instance = GrimoiresScene.instantiate()
	get_tree().root.add_child(instance)
	instance.party = party
	instance.close.connect(func():
		instance.queue_free()
		start_turn(manager.queue.current)
		)

func _on_grimoire_left_button_down() -> void:
	show_grimoires_popup(manager.party_a)

func _on_grimoire_right_button_down() -> void:
	show_grimoires_popup(manager.party_b)
