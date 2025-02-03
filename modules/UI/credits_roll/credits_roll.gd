@tool
extends ScrollContainer
class_name CreditsRoll

const DEFAULT_CONTENT = 'Fill your credits content :D'
const DEFAULT_MARGIN = 8

@export var content: CreditsContent:
	set(value):
		content = value
		populate_credits.call_deferred()

@export var in_editor_update_content: bool:
	set(_value):
		populate_credits.call_deferred()

@export var in_editor_show_scroll_margin: bool = true:
	get():
		if !margin_container: return true
		return margin_container.get_theme_constant("margin_top") != DEFAULT_MARGIN
	set(value):
		var margin = self.size.y if value else DEFAULT_MARGIN
		if !margin_container:
			set_deferred("in_editor_show_scroll_margin", value)
			return
		margin_container.add_theme_constant_override("margin_top", margin)
		margin_container.add_theme_constant_override("margin_bottom", margin)

@export_group("scrolling options")
@export var credits_duration: float = 0

signal credits_end

var margin_container: MarginContainer
var rich_text_label: RichTextLabel


var max_scroll: float:
	get():
		if !margin_container: return self.size.y
		return margin_container.size.y - self.size.y + DEFAULT_MARGIN * 2

@export_range(0, 1, 0.001) var scroll_vertical_ratio: float:
	get():
		return self.scroll_vertical / max_scroll
	set(value):
		self.set_deferred("scroll_vertical", value * max_scroll)
		if value == 1: credits_end.emit()


func _ready() -> void:
	for child in self.get_children():
		self.remove_child(child)
	
	rich_text_label = RichTextLabel.new()
	rich_text_label.bbcode_enabled = true
	rich_text_label.fit_content = true
	rich_text_label.scroll_active = false
	rich_text_label.size_flags_horizontal = Control.SIZE_FILL
	rich_text_label.size_flags_vertical = Control.SIZE_FILL
	populate_credits()

	margin_container = MarginContainer.new()
	margin_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin_container.add_theme_constant_override("margin_top", DEFAULT_MARGIN)
	margin_container.add_theme_constant_override("margin_bottom", DEFAULT_MARGIN)
	margin_container.add_child(rich_text_label)

	self.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
	self.add_child(margin_container)
	
	if Engine.is_editor_hint(): return
	if 0 < credits_duration:
		self.scroll_vertical_ratio = 0
		var tween = create_tween()
		tween.tween_property(self, "scroll_vertical_ratio", 1, credits_duration)


func populate_credits() -> void:
	if !content or content.is_empty():
		rich_text_label.text = DEFAULT_CONTENT
	else:
		content.populate_bbtext(rich_text_label)


func _process(delta: float) -> void:
	update_size()
	pass

func update_size() -> void:
	var height = self.size.y
	
	if Engine.is_editor_hint():
		if not in_editor_show_scroll_margin:
			height = DEFAULT_MARGIN
		return
	
	margin_container.add_theme_constant_override("margin_top", height)
	margin_container.add_theme_constant_override("margin_bottom", height)
