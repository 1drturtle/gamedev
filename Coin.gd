extends Area2D


func _on_Coin_body_entered(body):
	body.score += 1
	queue_free()
