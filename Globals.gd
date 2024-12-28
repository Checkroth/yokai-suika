extends Node

# enum Droppables { DEBUG_SPHERE, MEDAMA_OYAJI }
enum Droppables { DEBUG1, DEBUG2, DEBUG3, DEBUG4, DEBUG5, DEBUG6, DEBUG7, DEBUG8, DEBUG9, DEBUG10}

#const DROPPABLE_DATA:Dictionary = {
#	Droppables.DEBUG_SPHERE: preload("res://data/DebugSphere.tres"),
#	Droppables.MEDAMA_OYAJI: preload("res://data/MedamaOyaji.tres")
#}

const DROPPABLE_DATA = {
	Droppables.DEBUG1: preload("res://data/DebugData/DebugSphere.tres"),
	Droppables.DEBUG2: preload("res://data/DebugData/DebugSphere2.tres"),
	Droppables.DEBUG3: preload("res://data/DebugData/DebugSphere3.tres"),
	Droppables.DEBUG4: preload("res://data/DebugData/DebugSphere4.tres"),
	Droppables.DEBUG5: preload("res://data/DebugData/DebugSphere5.tres"),
	Droppables.DEBUG6: preload("res://data/DebugData/DebugSphere6.tres"),
	Droppables.DEBUG7: preload("res://data/DebugData/DebugSphere7.tres"),
	Droppables.DEBUG8: preload("res://data/DebugData/DebugSphere8.tres"),
	Droppables.DEBUG9: preload("res://data/DebugData/DebugSphere9.tres"),
	Droppables.DEBUG10: preload("res://data/DebugData/DebugSphere10.tres")
}
