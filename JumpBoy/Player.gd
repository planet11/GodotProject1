extends KinematicBody2D

signal lives_lost


var velocity = Vector2(0, 0)
var coins = 0
#var lives = 3
const SPEED = 200
const GRAVITY = 35
const JUMPFORCE = -800

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("run")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("run")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
	
	if not is_on_floor():
		$Sprite.play("air")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		#$Sprite.play("air")
		$SoundJump.play() ##play(0.1) for sound to play after 0.1 seconds
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.3)
	

func bounce():
	velocity.y = JUMPFORCE * 0.7

func ouch(var enemy_posx):
	emit_signal("lives_lost")
	set_modulate(Color(1, 0, 0, 0.6)) ## (R, G, B, alpha(for transparency))
	velocity.y = JUMPFORCE * 0.5
	$Timer.start()
	
	if position.x < enemy_posx: ## if player is on the left of the enemy
		velocity.x = -700
	elif position.x > enemy_posx:
		velocity.x = 700
	Input.action_release("left")
	Input.action_release("right")
	
	#$Timer.start()


func _on_Timer_timeout():
	#get_tree().change_scene("res://GameOver.tscn")
	set_modulate(Color(1, 1, 1, 1))


func _on_TimerRespawn_timeout():
	position = Vector2(120, 320)
	get_parent().get_node("HUD")._on_Player_lives_lost()
