extends Node

var spawn_longitude: int = 0
var score: int = 0
@onready var score_display: Label = %ScoreDisplay


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and !event.is_pressed():
		spawn_longitude = event.position.x
		_spawn_droppable(_choose_droppable())
		print("CLICKED")

func _choose_droppable() -> Droppable:
	return Globals.DROPPABLE_DATA[Globals.Droppables.MEDAMA_OYAJI]

func _add_to_score(points: int):
	score += points
	score_display.text = str(score)

func _upgrade(droppable: Droppable, prev_left: Vector2, prev_right: Vector2):
	var normalized_x = (prev_left.x + prev_right.x) / 2
	var normalized_y = (prev_left.y + prev_right.y) / 2
	var new_suika = droppable.instantiate()
	new_suika.drop_new.connect(_upgrade)
	add_child(new_suika)
	new_suika.position = Vector2(normalized_x, normalized_y)
	_add_to_score(droppable.combine_points)

func _spawn_droppable(droppable: Droppable):
	# var new_suika = droppable.scene.instantiate()
	var new_suika = droppable.instantiate()
	new_suika.drop_new.connect(_upgrade)
	add_child(new_suika)
	new_suika.position.x = spawn_longitude
	_add_to_score(droppable.combine_points)
