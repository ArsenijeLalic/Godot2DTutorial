extends Node

@export var mob_scene: PackedScene
@onready var score = 0
var paused: bool
@onready var hud = $HUD
var volume_change = 15

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	hud.game_over()
	$DeathSound.play()
	$Music.volume_db-=volume_change
	await get_tree().create_timer(2.0).timeout
	$Music.volume_db+=volume_change
	
func new_game():
	score = 0
	hud.update_score(score)
	hud.show_message("Get Ready!")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs","queue_free")


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
	hud.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
