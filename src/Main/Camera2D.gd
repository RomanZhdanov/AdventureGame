extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var buttomRight = $Limits/BottomRight

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = buttomRight.position.y
	limit_right = buttomRight.position.x

