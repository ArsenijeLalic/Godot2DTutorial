extends Node

@export var mob_scene: PackedScene
@onready var score = 0
var paused: bool

func _ready() -> void:
	new_game()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and paused == true:
		paused = false
		new_game()

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	paused = true
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation+PI/2
	direction+= randf_range(-PI/4,PI/4)
	
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_score_timer_timeout() -> void:
	score+=1


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
