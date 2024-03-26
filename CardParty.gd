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
	print(Card._CardFace + " selected")
	$DiscardPile.highLight()
	#check if selectedCard is owned by the ActivePlayer's Hand:
	if Card.get_parent().get_parent().PlayerName == playerMap[activePlayer].PlayerName:
		print("card owned by activePlayer")
		Card.selectCardSuccessful()
	else:
		Card.selectCardUnSuccessful()
		$DiscardPile.unhighLight()
		print("card owned by inactivePlayer")

func _on_card_unselect_attempted(Card):
	var current_mouse_pos = get_global_mouse_position()
	var discard_pile_pos = $DiscardPile.global_position
	var dropZoneDistance = 50
	
	var dis_to_discard_pile = current_mouse_pos.distance_to(discard_pile_pos)
	if dis_to_discard_pile < dropZoneDistance:
		print("inside DropZone")
		playerMap[activePlayer].removeCard(Card)
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
	$DiscardPile.addCard(Card)
	playerMap[activePlayer].addPointsToScore(Card.score)
	playerMap[activePlayer].removeCard(Card)
	switchActivePlayer()
	
	

func compareCards(cardFaceA:String, cardFaceB:String):
	print("comparing: " + cardFaceA + " to " + cardFaceB)
	var suitA = cardFaceA.substr(len(cardFaceA)-1)
	var suitB = cardFaceB.substr(len(cardFaceB)-1)
	var ValA = cardFaceA.substr(0,len(cardFaceA) -1)
	var ValB = cardFaceB.substr(0,len(cardFaceB) -1)
	if suitA == suitB:
		print("Suits Match")
		return true
	elif ValA == ValB:
		print("Val Match")
		return true
	else:
		print("No Match")
		return false
	
	
func highlightActivePlayer():
	print("Active Player: " + playerMap[activePlayer].PlayerName)
	playerMap[activePlayer].highlightPlayer()
	playerMap[activePlayer * -1].unhighlightPlayer()
	
	
func switchActivePlayer():
	activePlayer = activePlayer * -1
	playerMap[activePlayer].drawCardsInHand()
	highlightActivePlayer()
	
func _on_deck_draw_card(cardFace):
	print("Drew: ", cardFace)
	var newCard = CardStyle.instantiate()
	newCard.setCardFace(cardFace)
	newCard.card_select_attempted.connect(_on_card_select_attempted)
	newCard.card_unselect_attempted.connect(_on_card_unselect_attempted)
	playerMap[activePlayer].addCard(newCard)
	



func _on_button_pressed():
	switchActivePlayer()
