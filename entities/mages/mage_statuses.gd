extends Resource
class_name MageStatuses

signal updated

var list: Array[Status]

func _init(forward_signal: Signal):
	updated.connect(forward_signal.emit)

func add(status: Status):
	list.push_back(status)
	updated.emit()

func remove(status_name: String):
	list = list.filter(func(item): return item.name() != status_name)
	updated.emit()

func process(hook: String, args: Array):
	var return_value = args.front()
	for status in list:
		return_value = (status[hook] as Callable).callv(args)
		if return_value:
			args[0] = return_value
	
	return return_value

func auto_clear(action: BattleAction) -> void:
	for status in list:
		if status.clear_type() != Status.ClearType.custom: continue
		if not status.should_clear(action): continue
		remove(status.name())
