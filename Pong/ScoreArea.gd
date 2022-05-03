extends Area2D

signal update_score


func _ready():
	self.connect("body_entered", self, "_on_score")
	self.connect("update_score", get_node(".."), "update_score")


func _on_score(body):
	if body.name == "Ball":
		if body.velocity.x > 0:
			emit_signal("update_score", 1)
		elif body.velocity.x < 0:
			emit_signal("update_score", 2)

