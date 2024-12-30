class_name SuikaBase extends RigidBody2D

@export var collision_space: CollisionPolygon2D
@export var sprite: Sprite2D

var droppable: Droppable

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
func freeze():
	# Used for preparing an object to drop at the top, but allowing it to
	#    visibly slide along the top until the player is ready to drop it.
	pass

func unfreeze():
	pass

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
