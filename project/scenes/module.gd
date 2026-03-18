extends Node3D

@export_dir var modules_dir: String:
    set(new_modules_dir):
        _update_modules(new_modules_dir)
        modules_dir = new_modules_dir
        notify_property_list_changed()  

@export var selected_module: String:
    set(new_module):
        selected_module = new_module    
        notify_property_list_changed()
        _load_module()

var module_names: Array[String]
var loaded_modules: Array[]

func _ready() -> void:
    if Engine.is_editor_hint():
        if modules_dir:
            _update_modules(modules_dir)
    else:
        module_names.clear()
        _load_module()
    
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
            selected_module = module_names[0]        
                
func _load_module() -> void:
    print('load module')
    if _instance:        
        print('replacing')
        remove_child(_instance)
        _instance.queue_free()    
        _instance = null
        
    var path = modules_dir + '/' + selected_module
    print(path)
    var resource = ResourceLoader.get_cached_ref(path)
    
    if !resource:
        print('not cached, loading')
        resource = ResourceLoader.load(path)
    else:
        print('cached')
        
    if resource:
        print('loaded')
        _instance = resource.instantiate()
        add_child(_instance)

func _validate_property(property: Dictionary) -> void:
    if property.name == "selected_module":
        property.type = TYPE_STRING
        property.hint = PROPERTY_HINT_ENUM
        property.hint_string = ",".join(module_names)
