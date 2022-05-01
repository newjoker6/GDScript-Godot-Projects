extends Control

var base_url = 'https://api.openweathermap.org/data/2.5/weather?'
var city: String
var state_code: String 
var country_code: String 
var unit: String
var feels_like : float
var temp : float
var humidity: float
var weather: String


func _ready():
	connect_signals()


func connect_signals():
	self.get_node("TempButton").connect('pressed', self, '_on_button_pressed')
	self.get_node("HTTPRequest").connect("request_completed", self, '_on_HTTPRequest_request_completed')


func _on_button_pressed():
	city = self.get_node("CityInput").text
	state_code = self.get_node("StateInput").text
	country_code = self.get_node("CountryInput").text
	unit = self.get_node("UnitInput").text
	get_node("HTTPRequest").request('%sq=%s,%s,%s&appid=%s&units=%s' %[base_url, city, state_code, country_code, API_KEY, unit])


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	
	feels_like = stepify(response['main']['feels_like'], 0.01)
	temp = stepify(response['main']['temp'], 0.01)
	humidity = stepify(response['main']['humidity'], 0.01)
	weather = response['weather'][0]['description']
	display_weather(feels_like, temp, humidity, weather)


func display_weather(feels:float, tempr:float, humid:float, weather_c:String):
	self.get_node("WeatherInfo").clear()
	self.get_node("WeatherInfo").add_text('Feels Like: %s degrees\n' %feels\
										+'Temperature: %s degrees\n' %tempr\
										+'Humidity: %s\n' %humid\
										+'Weather: %s\n' %weather_c)
