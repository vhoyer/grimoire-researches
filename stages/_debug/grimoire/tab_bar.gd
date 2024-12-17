extends TabBar

var mages: Array[Mage] = [
	Mage.new('Andre'),
	Mage.new('Lucas'),
	Mage.new('Julio'),
];

@onready var book: PanelContainer = %Book

func _ready() -> void:
	_on_tab_changed(self.current_tab)

func _on_tab_changed(tab: int) -> void:
	book.change_grimoire(mages[tab].grimoire)
