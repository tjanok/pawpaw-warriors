extends Node2D

export (PackedScene) var Mob
var score

func _ready():
	randomize()


func _on_Player_hit():
	pass # Replace with function body.

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.set_offset(randi())
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	var pos = Vector2( 1000, 500 );
	pos = $StartPosition.position
	#pos.x = rand_range( 0, get_viewport().get_visible_rect().size.x-16);
	#pos.y = rand_range( 0, get_viewport().get_visible_rect().size.y );
	
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.get_node("RigidBody2D").rotation = direction
	# Set the velocity (speed & direction).
	mob.get_node("RigidBody2D").linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.get_node("RigidBody2D").linear_velocity = mob.get_node("RigidBody2D").linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_HUD_start_game():
	new_game();
