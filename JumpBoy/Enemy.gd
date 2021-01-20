extends KinematicBody2D

var speed = 50
var velocity = Vector2()
export var direction = -1
export var detect_cliff = true

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_radius() * direction ##   get_extents().x for rectangleshape2D
	$floor_checker.enabled = detect_cliff
	
	if detect_cliff:
		set_modulate(Color(0, 1, 0, 1))

func _physics_process(delta):
	
	if is_on_wall() or not $floor_checker.is_colliding() and detect_cliff and is_on_floor():
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h ## to change the flip direction
		$floor_checker.position.x = $CollisionShape2D.shape.get_radius() * direction
		
	
	velocity.y += 20
	   
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_top_checker_body_entered(body):
	$AnimatedSprite.play("squashed")
	$SoundSquashed.play()
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(4, false)
	$top_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_layer_bit(4, false)
	$sides_checker.set_collision_mask_bit(0, false)
	$bottom_checker.set_collision_layer_bit(4, false)
	$bottom_checker.set_collision_mask_bit(0, false)
	$Timer.start()
	body.bounce()


func enemy_bounce():
	velocity.y = -200


func _on_sides_checker_body_entered(body):
	print("ouch!")
	body.ouch(position.x)
	$SoundHurt.play()


func _on_bottom_checker_body_entered(body):
	body.ouch(position.x)
	enemy_bounce()



func _on_Timer_timeout():
	queue_free()
