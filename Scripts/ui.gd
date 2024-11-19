extends CanvasLayer

@onready var label: Label = %Label
@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar


func _ready() -> void:
	SignalBus.update_ammo_ui.connect(label_text)
	SignalBus.update_health_ui.connect(health_value)
	label_text()

func label_text() -> void:
	label.text = str(Global.bullet_in_clip) + " / " + str(Global.bullet_amount)

func health_value(health: int, max_health: int) -> void:
	texture_progress_bar.value = health
	texture_progress_bar.max_value = max_health
