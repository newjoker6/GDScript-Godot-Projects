extends Control


var data : PoolStringArray
var url: String #https://www.etsy.com/ca/listing/970489214/personalized-signet-ring-statement-ring?click_key=7d7ec2c54af7cf801d5b9cd36e26fef88642412a%3A970489214&click_sum=81e6e40c&ref=hp_editors_picks_primary-5
var sources := ['select source', 'etsy']
var selected_site: String


func _ready():
	connect_signals()
	add_items()


func add_items():
	for s in sources:
		get_node("OptionButton").add_item(s)
	get_node("OptionButton").set_item_disabled(0, true)


func connect_signals():
	get_node("SearchButton").connect('pressed', self, '_on_Search_pressed')
	get_node("HTTPRequest").connect('request_completed', self, '_on_request_completed')
	get_node("OptionButton").connect('item_selected', self, '_on_item_selected')


func _on_item_selected(index):
	selected_site = get_node("OptionButton").get_item_text(index)


func _on_request_completed(result, response_code, headers, body):
	var response = body.get_string_from_utf8()

	match selected_site:
		'etsy':
			var price
			if "Price:" in response:
				data = response.split('Price:')
				price = str(data[1]).split('</p>')
				price = str(price[0].replace("</span>", ""))
				price = price.split(" ")
				for space in price:
					if "$" in space:
						price = space
			else:
				data = response.split('<p class="wt-text-title-03 wt-mr-xs-2">')
				price = str(data[1]).split('</p>')
				price = str(price[0].strip_edges())

			get_node("PriceLabel").text = 'The current price is: %s' %price
	
		_:
			get_node("PriceLabel").text = 'error'


func _on_Search_pressed():
	if get_node("URLentry").text == '':
		get_node("PriceLabel").text = "error"
		return
	url = get_node("URLentry").text
	get_node("PriceLabel").text = "Searching..."
	get_node("HTTPRequest").request(url)
