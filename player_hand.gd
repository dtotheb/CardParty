extends Node2D

var cardWidth = Vector2(50,0)
@export var PlayerName:String = "Player1"
@export var MaxHandSize : int = 5
@export var CardStyle:PackedScene
var Cards = []


# Called when the node enters the scene tree for the first time.
func _ready():
	setPlayerLabel()
	drawCardsInHand()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func drawCardsInHand():
	
	for child in $MyCards.get_children():
		child.queue_free()
	
	var HandSize = len(Cards)
	var curCard = 0
	for card in Cards:
		var newCard = CardStyle.instantiate()
		newCard._CardFace = card
		newCard.position = $MyCards.position + (cardWidth * curCard )
		$MyCards.add_child(newCard)
		curCard += 1


func setPlayerLabel():
	$PlayerLabel.text = PlayerName + " - " + str(len(Cards)) + "/" + str(MaxHandSize) + " Cards"


func addCard(cardVal):
	Cards.append(cardVal)
	setPlayerLabel()
	drawCardsInHand()
