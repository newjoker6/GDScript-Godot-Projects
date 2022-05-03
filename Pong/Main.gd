extends Node2D

var direction:= 1


func update_score(id):
	direction *= -1
	get_node("P%sScore" %id).text = str(int(get_node("P%sScore" %id).text) + 1)
	update_ball(get_node("Ball"))


func update_ball(ball):
	ball.position = OS.window_size/2
	ball.velocity.x = ball.speed * direction
	ball.velocity.y = ball.speed * direction
