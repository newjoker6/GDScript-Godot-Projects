extends KinematicBody2D


var velocity:= Vector2.ZERO
var speed:= 3
export var id:int = 1


func _ready():
	get_node("Area2D").connect("body_entered", self, "_on_ball_hit")


func _process(delta):
	move_and_collide(velocity)


func _input(event):
	if Input.is_action_pressed("up%s" %id):
		velocity.y = -speed
	elif Input.is_action_pressed("down%s" %id):
		velocity.y = speed
	else:
		velocity.y = 0


func _on_ball_hit(body):
	if body.name == "Ball":
		body.velocity.x *= -1.1
