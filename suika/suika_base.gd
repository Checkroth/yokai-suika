class_name SuikaBase extends RigidBody2D

@export var collision_space: CollisionPolygon2D
@export var sprite: Sprite2D

var droppable: Droppable
var in_play_collision_layer = 1

signal drop_new


var fusing_deferred = false

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	contact_monitor = true
	max_contacts_reported = 1
	
func configure(target_droppable: Droppable):
	droppable = target_droppable
	collision_space.scale = Vector2(droppable.scale, droppable.scale)
	sprite.scale = Vector2(droppable.scale, droppable.scale)

func _toggle_collision(value: bool):
	set_collision_layer_value(in_play_collision_layer, value)
	set_collision_mask_value(in_play_collision_layer, value)

func freeze_body():
	# Used for preparing an object to drop at the top, but allowing it to
	#    visibly slide along the top until the player is ready to drop it.
	freeze = true
	lock_rotation = true
	_toggle_collision(false)

func unfreeze_body():
	freeze = false
	lock_rotation = false
	_toggle_collision(true)

func _on_body_entered(body):
	# Defer fusing so that multiple bodies don't try to process simultaneously
	if body is SuikaBase and !body.fusing_deferred:
		if body.droppable == droppable:
			body.fusing_deferred = true
			fusing_deferred = true
			# var droppable_instance: Droppable = Globals.DROPPABLE_DATA[droppable]
			# drop_new.emit(droppable_instance.next_droppable)
			drop_new.emit(droppable.next_droppable, position, body.position)
			body.queue_free()
			queue_free()
