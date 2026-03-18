class_name Modules
extends Resource

@export_dir var modules_dir: String:
	set(new_modules_dir):
		_update_modules(new_modules_dir)
		modules_dir = new_modules_dir
		notify_property_list_changed()

var module_names: Array[String]
var modules_instances: Array[PackedScene]

func _init() -> void:
	if modules_dir:
		_update_modules(modules_dir)

# Called when the node enters the scene tree for the first time.
func _update_modules(update_dir) -> void:
	if Engine.is_editor_hint():        
		var dir = DirAccess.open(update_dir)
		if dir:
			module_names.clear()
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if dir.current_is_dir():
					pass
				elif !file_name.ends_with('.import'):
					module_names.append(file_name)
				file_name = dir.get_next()
