extends HBoxContainer

@export var QueueIconScene: PackedScene;
var battle_queue: BattleQueue:
	set(value):
		battle_queue = value;
		battle_queue.updated.connect(update_ui)
		update_ui()

func init_queue(members: Array[Mage]) -> void:
	battle_queue = BattleQueue.new(members)

func update_ui() -> void:
	for child in self.get_children(): child.queue_free()
	for mage in battle_queue.queue:
		var instance = QueueIconScene.instantiate()
		instance.mage = mage
		self.add_child(instance)
