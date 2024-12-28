class_name Droppable extends Resource

# Weight of this droppable for the "next drop". The higher the number, the more frequent it will appear.
@export var spawn_rate: int = 1

# Used for display and debug purposes only
@export var name: String

# The actual scene that will be loaded when this droppable is "dropped"
@export var scene: PackedScene

# The number of points accrued when colliding with another droppable of the same type
@export var combine_points: int

# The droppable type that this droppable will become when colliding with another of the same type
@export var next_droppable: Droppable

# The size of the droppable. All droppable assets are 250x250px, and their actual game size is a reduction or increase of that.
@export var scale: float


func instantiate():
	var instantiated = scene.instantiate()
	instantiated.configure(self)
	return instantiated
