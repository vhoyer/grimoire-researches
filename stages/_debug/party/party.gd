extends CanvasLayer

var party:= Party.new([Mage.new()]):
	set(value):
		party = value
		update_tab_bar()

signal close

@onready var tab_bar: TabBar = $MarginContainer/VBoxContainer/HBoxContainer/TabBar
@onready var book: PanelContainer = %Book

func _ready() -> void:
	_on_tab_bar_tab_changed(tab_bar.current_tab)


func update_tab_bar() -> void:
	tab_bar.clear_tabs()
	for mage in party.members:
		tab_bar.add_tab(mage.name)


func _on_close_button_down() -> void:
	close.emit()


func _on_tab_bar_tab_changed(tab: int) -> void:
	book.change_grimoire(party.members[tab].grimoire)


func _on_name_button_button_down() -> void:
	var root = get_tree().root
	var inst = UI.PROMPT_DIALOG.instantiate()
	inst.value = party.members[tab_bar.current_tab].name
	inst.cancel.connect(func():
		root.remove_child(inst)
		)
	inst.ok.connect(func(value: String):
		party.members[tab_bar.current_tab].name = value
		tab_bar.set_tab_title(tab_bar.current_tab, value)
		root.remove_child(inst)
		)
	root.add_child(inst)
