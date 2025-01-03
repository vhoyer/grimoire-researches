extends CanvasLayer

var party: Array[Mage] = [Mage.new()]:
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
	for mage in party:
		tab_bar.add_tab(mage.name)

func _on_close_button_down() -> void:
	close.emit()

func _on_tab_bar_tab_changed(tab: int) -> void:
	book.change_grimoire(party[tab].grimoire)
