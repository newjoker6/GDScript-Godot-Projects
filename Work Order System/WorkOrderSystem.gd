extends Control


var API_KEY = 'YOUR API KEY'
var url_base = 'http://www.mapquestapi.com/directions/v2/route'
var city = 'city+state+country'
var from_location = ''
var to_location = ''
var url = '%s?key=%s&from=%s+%s&to=%s+%s' %[url_base, API_KEY, from_location, city, to_location, city]


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	list_directions(response['route']['legs'][0]['maneuvers'])


func list_directions(directions):
	for d in directions:
		if d['narrative']:
			$Directions.add_text(str(d['narrative']))
			$Directions.newline()


func _on_DirectionButton_pressed():
	format_search()
	$Directions.clear()
	url = '%s?key=%s&from=%s+%s&to=%s+%s' %[url_base, API_KEY, from_location, city, to_location, city]
	$HTTPRequest.request(url)


func format_search():
	for c in $ToLocation.text:
		if c == " ":
			c = '+'
		to_location += c
		
	for c in $FromLocation.text:
		if c == " ":
			c = '+'
		from_location += c
