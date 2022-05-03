extends Control

enum States {
	WORK,
	BREAK
}
var Mode:int
	
var seconds : float
var minute : int
var countdown := false
var screen_size := OS.get_screen_size()
var window_size := OS.get_window_size()


func _ready():
	connect_signals()
	set_mode(States.WORK)
	update_time()


func _process(delta):
	if countdown == true:
		count_down(delta)
		update_time()


func connect_signals():
	get_node("Button").connect("pressed", self, 'start_count')


func set_mode(new_state):
	Mode = new_state
	if Mode == States.WORK:
		minute = 25
		seconds = 00
		change_button_text("Start Work")
	if Mode == States.BREAK:
		minute = 5
		seconds = 00
		change_button_text("Start Break")


func count_down(delta):
	seconds -= delta
	if seconds < 0:
		seconds = 59
		minute -= 1
	if round(seconds) == 0 and minute == 0:
		countdown = false
		get_node("Button").disabled = false
		popup_window()
		change_state()


func update_time():
	if round(seconds) >= 10:
		get_node("Label").text = '%s:%s'%[minute, round(seconds)]
	else:
		get_node("Label").text = '%s:0%s'%[minute, round(seconds)]


func popup_window():
	OS.window_position = screen_size*0.5 - window_size*0.5
	OS.set_window_always_on_top(true)
	OS.set_window_always_on_top(false)


func change_state():
	if Mode == States.WORK:
		set_mode(States.BREAK)
		return
	set_mode(States.WORK)


func change_button_text(text):
	get_node("Button").text = text


func start_count():
	countdown = true
	get_node("Button").disabled = true
