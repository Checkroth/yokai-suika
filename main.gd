extends Node

var spawn_longitude: float = 0
var score: int = 0
var hanging_suika: SuikaBase
@onready var score_display: Label = %ScoreDisplay
@onready var game_area: Control = %GameArea
@onready var spawn_timer: Timer = %SpawnTimer
var spawn_wait_time_seconds: float = 1.0

# Attributes of game_area, used for clamping. Set on ready
var min_x: float
var max_x: float
var spawn_latitude: float


# Called when the node enters the scene tree for the first time.
func _ready():
	min_x = game_area.position.x
	max_x = min_x + game_area.size.x
	# min_x = game_area.left
	# max_x = game_area.anchor_right
	spawn_latitude = game_area.position.y
	_spawn_droppable()

func clamp_x(clamp_target: float):
	if clamp_target < min_x:
		return min_x
	elif clamp_target > max_x:
		return max_x
	else:
		return clamp_target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_position = game_area.get_global_mouse_position()
	spawn_longitude = clamp_x(mouse_position.x)
	if hanging_suika != null:
		hanging_suika.position.x = spawn_longitude

func _input(event):
	if event is InputEventMouseButton and !event.is_pressed():
		spawn_longitude = event.position.x
		call_deferred("_drop_droppable")

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

func _spawn_droppable():
	# var new_suika = droppable.scene.instantiate()
	var droppable = _choose_droppable()
	var new_suika = droppable.instantiate()
	new_suika.drop_new.connect(_upgrade)
	add_child(new_suika)
	new_suika.position = Vector2(spawn_longitude, spawn_latitude)
	new_suika.freeze_body()
	hanging_suika = new_suika	

func _drop_droppable():
	if hanging_suika == null:
		return
	_add_to_score(hanging_suika.droppable.combine_points)
	hanging_suika.unfreeze_body()
	hanging_suika = null
	spawn_timer.start(spawn_wait_time_seconds)
