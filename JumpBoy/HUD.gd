extends CanvasLayer

var coins = 0
var lives = 5

func _ready():
	$CoinsTotal/CoinNum.text = String(coins)
	$LivesLeft/LifeNum.text = String(lives)

func _on_coin_collected():
	coins += 1
	_ready()
	if coins == 69:
		get_tree().change_scene("res://YouWin.tscn")
		

func _on_Player_lives_lost():
	lives -= 1
	_ready()
	if lives == 0:
		$Timer.start()
		
func _on_Timer_timeout():
	get_tree().change_scene("res://GameOver.tscn")


func _on_FallZone_body_entered(body):
	$TimerRespawn.start()
	print("hello3")
