extends Node

signal progress_changed(progress)
signal load_finished

# 1. Preload your loading screen here so you don't have to assign it manually
var loading_screen: PackedScene = preload("res://loading_screen.tscn")
var loaded_resource: PackedScene
var scene_path: String
var progress: Array = []
var use_sub_threads: bool = true

func _ready() -> void:
	set_process(false)

func load_scene(_scene_path: String) -> void:
	scene_path = _scene_path
	
	var new_load_screen = loading_screen.instantiate()
	# Add the screen to the very root of the game so it doesn't get 
	# destroyed when the old scene is removed
	get_tree().root.add_child(new_load_screen) 
	
	progress_changed.connect(new_load_screen._on_progress_changed)
	load_finished.connect(new_load_screen._on_load_finished)
	
	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(_delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
			print("Error: Could not load scene at path: ", scene_path)
			
		ResourceLoader.THREAD_LOAD_LOADED:
			set_process(false)
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(loaded_resource)
			get_tree().paused = true
			load_finished.emit()
