extends Area2D

signal coin_collected()

func _on_Coin_body_entered(body):
	$AnimationPlayer.play("bounce")
	emit_signal("coin_collected")
	set_collision_mask_bit(0, false) ## to prevent coin collection twice by turning off the coin mask as player hits it 
	$SoundCoinCollect.play()
	#body.add_coin()


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
