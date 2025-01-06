extends HBoxContainer

@export var QueueIconScene: PackedScene;
@export var battle_queue: BattleQueue:
	set(value):
		battle_queue = value;
		battle_queue.updated.connect(update_ui)
		update_ui()

func init_queue(battle_queue: BattleQueue) -> void:
	self.battle_queue = battle_queue

func update_ui() -> void:
	for child in self.get_children(): child.queue_free()
	for turn in battle_queue.queue:
		var instance = QueueIconScene.instantiate()
		instance.mage = turn.member
		instance.is_current = battle_queue.is_current(turn)
		self.add_child(instance)
		self.move_child(instance, 0)
