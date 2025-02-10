extends Node

@export var mob_scene: PackedScene
var score
var mobs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	for mob in mobs:
		# Gets the players position
		var player_position = $Player.position
	
		# Makes the mob look at the player.
		mob.look_at(player_position)

		# Calculate the direction vector from the mob to the player.
		var direction_vector = (player_position - mob.position).normalized()

		# Choose the velocity for the mob.
		var speed = randf_range(150.0, 250.0)
		mob.linear_velocity = direction_vector * speed

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	despawn_mobs()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	# Add the mob to the array of mobs
	mobs.append(mob)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func despawn_mobs():
	for mob in mobs:
		mob.queue_free()
	mobs.clear()
