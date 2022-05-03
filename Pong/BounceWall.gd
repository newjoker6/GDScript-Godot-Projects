extends Area2D



func _ready():
	self.connect("body_entered", self, "_on_bounce_detected")


func _on_bounce_detected(body):
	if body.name == "Ball":
		body.velocity.y *= -1
