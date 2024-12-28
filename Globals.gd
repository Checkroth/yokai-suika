extends Node

enum Droppables { DEBUG_SPHERE, MEDAMA_OYAJI }

const DROPPABLE_DATA:Dictionary = {
	Droppables.DEBUG_SPHERE: preload("res://data/DebugSphere.tres"),
	Droppables.MEDAMA_OYAJI: preload("res://data/MedamaOyaji.tres")
}
