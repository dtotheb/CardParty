extends Node2D

var Cards = []
var CD = CardDetails.new()
var CardFaceMap = CD.getCardFaceMap("tinyFaces")

signal draw_card(cardFace)


# Called when the node enters the scene tree for the first time.
func _ready():
	generateDeck()
	

func setDeckSizeLabel(count):
	$Label.text = str(count) + " Cards"


func generateDeck(shuffle=true):
	Cards = []
	for card in CardFaceMap.keys():
			Cards.append(card)
	setDeckSizeLabel(len(Cards))
	if shuffle:
		Cards.shuffle()

func drawCard():
	if len(Cards) > 0:
		var topCard = Cards[0]
		Cards.remove_at(0)
		setDeckSizeLabel(len(Cards))
		emit_signal("draw_card",topCard)
	else:
		print("Deck is Empty!")
		return null
	

func on_click():
	drawCard()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func setCards(cardList):
	Cards = cardList

func get_CardCount():
	return len(Cards)




func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			on_click()
