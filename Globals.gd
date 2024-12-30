extends Node

# These only have to contain the items we want the player to beable to drop, not every
#    implementation of a yokai.
enum Droppables { MEDAMA_OYAJI, KURABOKKO, ZASHIKIWARASHI, DOROTABO, KASABAKE }

const DROPPABLE_DATA:Dictionary = {
	Droppables.MEDAMA_OYAJI: preload("res://data/yokai/1_MedamaOyaji.tres"),
	Droppables.KURABOKKO: preload("res://data/yokai/2_Kurabokko.tres"),
	Droppables.ZASHIKIWARASHI: preload("res://data/yokai/3_Zashikiwarashi.tres"),
	Droppables.DOROTABO: preload("res://data/yokai/4_Dorotabo.tres"),
	Droppables.KASABAKE: preload("res://data/yokai/5_Kasabake.tres"),
}

# enum Droppables { MEDAMA_OYAJI, DEBUG2, DEBUG3, DEBUG4, DEBUG5, DEBUG6, DEBUG7, DEBUG8, DEBUG9, DEBUG10}
# const DROPPABLE_DATA = {
# 	Droppables.MEDAMA_OYAJI: preload("res://data/DebugData/DebugSphere.tres"),
# 	Droppables.DEBUG2: preload("res://data/DebugData/DebugSphere2.tres"),
# 	Droppables.DEBUG3: preload("res://data/DebugData/DebugSphere3.tres"),
# 	Droppables.DEBUG4: preload("res://data/DebugData/DebugSphere4.tres"),
# 	Droppables.DEBUG5: preload("res://data/DebugData/DebugSphere5.tres"),
# 	Droppables.DEBUG6: preload("res://data/DebugData/DebugSphere6.tres"),
# 	Droppables.DEBUG7: preload("res://data/DebugData/DebugSphere7.tres"),
# 	Droppables.DEBUG8: preload("res://data/DebugData/DebugSphere8.tres"),
# 	Droppables.DEBUG9: preload("res://data/DebugData/DebugSphere9.tres"),
# 	Droppables.DEBUG10: preload("res://data/DebugData/DebugSphere10.tres")
# }
