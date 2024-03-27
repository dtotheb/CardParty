extends Node2D
@export var CardStyle:PackedScene



var activePlayer:int = 1
var playerMap

func setupPlayerMap():
	var player1 = get_node("PlayerHand1")
	var player2 = get_node("PlayerHand2")
	return { 1 : player1, -1: player2 }

# Called when the node enters the scene tree for the first time.
func _ready():
	playerMap = setupPlayerMap()
	setupGame()
	highlightActivePlayer()
	

func setupGame(startingHandSize:int = 4):
	for i in range(0, startingHandSize * 2):
		var newCardFace = $Deck.drawCard()
		switchActivePlayer()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_card_select_attempted(Card):
	$DiscardPile.highLight()
	#check if selectedCard is owned by the ActivePlayer's Hand:
	if Card.get_parent().get_parent().PlayerName == playerMap[activePlayer].PlayerName:
		Card.selectCardSuccessful()
	else:
		Card.selectCardUnSuccessful()
		$DiscardPile.unhighLight()


func _on_card_unselect_attempted(Card):
	var current_mouse_pos = get_global_mouse_position()
	var discard_pile_pos = $DiscardPile.global_position
	var dropZoneDistance = 50
	
	var dis_to_discard_pile = current_mouse_pos.distance_to(discard_pile_pos)
	if dis_to_discard_pile < dropZoneDistance:
		#playerMap[activePlayer].removeCard(Card)
		var TopCard = $DiscardPile.getTopCard()
		if TopCard == null:
			PlayCardToDiscardPile(Card)
		else:
			if compareCards(Card._CardFace, TopCard):
				PlayCardToDiscardPile(Card)
			else:
				Card.unselectCardSuccessful()
			
	
	$DiscardPile.unhighLight()
	
func PlayCardToDiscardPile(Card):
	playerMap[activePlayer].addPointsToScore(Card.score)
	$DiscardPile.addCard(Card)
	
	var cardsInHand = playerMap[activePlayer].getCardCount()
	print(str(cardsInHand) + " left in " + playerMap[activePlayer].PlayerName + " hand")
	
	playerMap[activePlayer].removeCard(Card)
	
	cardsInHand = playerMap[activePlayer].getCardCount()
	print(str(cardsInHand) + " left in " + playerMap[activePlayer].PlayerName + " hand")
	
	switchActivePlayer()
	
	

func compareCards(cardFaceA:String, cardFaceB:String):
	var suitA = cardFaceA.substr(len(cardFaceA)-1)
	var suitB = cardFaceB.substr(len(cardFaceB)-1)
	var ValA = cardFaceA.substr(0,len(cardFaceA) -1)
	var ValB = cardFaceB.substr(0,len(cardFaceB) -1)
	if suitA == suitB:
		return true
	elif ValA == ValB:
		return true
	else:
		return false
	
	
func highlightActivePlayer():
	playerMap[activePlayer].highlightPlayer()
	playerMap[activePlayer * -1].unhighlightPlayer()
	
	
func switchActivePlayer():
	playerMap[activePlayer].drawCardsInHand()
	activePlayer = activePlayer * -1
	playerMap[activePlayer].drawCardsInHand()
	highlightActivePlayer()
	
func _on_deck_draw_card(cardFace):
	var newCard = CardStyle.instantiate()
	newCard.setCardFace(cardFace)
	newCard.card_select_attempted.connect(_on_card_select_attempted)
	newCard.card_unselect_attempted.connect(_on_card_unselect_attempted)
	playerMap[activePlayer].addCard(newCard)
	



func _on_button_pressed():
	switchActivePlayer()
