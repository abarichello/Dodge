extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_StartTimer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1

func _on_EnemyTimer_timeout():
	$EnemyPath/EnemyPath/EnemySpawnLocation.set_offset(randi())
	var enemy = Enemy.instance()
	add_child(enemy)
	var direction = $EnemyPath/EnemySpawnLocation.rotation + PI/2
	enemy.position = $EnemyPath/EnemyPath/EnemySpawnLocation.position
	direction += rand_range(deg2rad(275), deg2rad(45))
	enemy.rotation = direction
	enemy.set_linear_velocity(Vector2(rand_range(enemy.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))

func _game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
