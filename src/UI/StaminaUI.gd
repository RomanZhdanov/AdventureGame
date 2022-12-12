extends Control

var stamina = 10 setget set_stamina
var max_stamina = 10 setget set_max_stamina

onready var staminaBar = $StaminaBar

func set_stamina(value):
	stamina = clamp(value, 0, max_stamina)
	staminaBar.value = stamina

func set_max_stamina(value):
	max_stamina = max(value, 1)
	staminaBar.max_value = max_stamina
	self.stamina = min(stamina, max_stamina)

func _ready():
	self.max_stamina = PlayerStats.max_stamina
	self.stamina = PlayerStats.stamina
	# warning-ignore:return_value_discarded
	PlayerStats.connect("stamina_changed", self, "set_stamina")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("max_stamina_changed", self, "set_max_stamina")
