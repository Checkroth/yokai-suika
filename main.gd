extends Node

var spawn_longitude: float = 0
var score: int = 0
var hanging_suika: SuikaBase
@onready var score_display: Label = %ScoreDisplay
@onready var game_area: Control = %GameArea
@onready var spawn_timer: Timer = %SpawnTimer
@onready var game_over_timer: Timer = %GameOverTimer
@onready var game_over_area: Area2D = %GameOverDetector
@onready var game_over_label: Label = %"Game Over"
var spawn_wait_time_seconds: float = 1.0
@export var game_over_wait_time: float = 5.0

var rng = RandomNumberGenerator.new()
var drop_select_list: Array[Droppable] = []
var encountered_list: Dictionary = {Globals.DROPPABLE_DATA[Globals.Droppables.MEDAMA_OYAJI]: null}

enum GAME_STATE {
	RUNNING, FAILED
}
var game_state = GAME_STATE.RUNNING



# Attributes of game_area, used for clamping. Set on ready
var min_x: float
var max_x: float
var spawn_latitude: float


# Called when the node enters the scene tree for the first time.
func _ready():
	# Create the weighted list of selectable spawn items
	for spawnable:Droppable in Globals.DROPPABLE_DATA.values():
		for i in range(spawnable.spawn_rate):
			drop_select_list.append(spawnable)
	# Set the parameters of the game to lock spawning in the game area
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
	if game_state == GAME_STATE.FAILED:
		# Cancel all further input
		return
	var mouse_position = game_area.get_global_mouse_position()
	spawn_longitude = clamp_x(mouse_position.x)
	if hanging_suika != null:
		hanging_suika.position.x = spawn_longitude

func _input(event):
	if game_state == GAME_STATE.FAILED:
		return
	if event is InputEventMouseButton and !event.is_pressed():
		spawn_longitude = event.position.x
		call_deferred("_drop_droppable")

func _choose_droppable() -> Droppable:
	var new_droppable = drop_select_list.pick_random()
	while !encountered_list.has(new_droppable):
		new_droppable = drop_select_list.pick_random()
	return new_droppable

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
	encountered_list[droppable] = null
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


func _game_over_area_entered(_body):
	# If a suika is in the game over area, we start the game over timer.
	# If the physics engine doesn't get the item out of the game over area in time,
	#    the player loses the game.
	if game_over_timer.is_stopped():
		game_over_timer.start(game_over_wait_time)

func _game_over_area_exited(_body):
	# When a suika leaves the game over area, check if we have any other suika in the area.
	# If we don't, cancel the timer as the physics engine has cleared the area and the player
	#    should not be in a "game over" state anymore.
	if !game_over_area.has_overlapping_bodies():
		game_over_timer.stop()

func _game_over():
	game_over_label.show()
	spawn_timer.stop()
