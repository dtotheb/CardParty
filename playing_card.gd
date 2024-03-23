extends Node2D

var CardFaceMap = {
	"Ah": { "suit": "hearts", "frame": 0 },
	"2h": { "suit": "hearts", "frame": 1 },
	"3h": { "suit": "hearts", "frame": 2 },
	"4h": { "suit": "hearts", "frame": 3 },
	"5h": { "suit": "hearts", "frame": 4 },
	"6h": { "suit": "hearts", "frame": 5 },
	"7h": { "suit": "hearts", "frame": 6 },
	"8h": { "suit": "hearts", "frame": 7 },
	"9h": { "suit": "hearts", "frame": 8 },
	"10h": { "suit": "hearts", "frame": 9 },
	"Jh": { "suit": "hearts", "frame": 10 },
	"Qh": { "suit": "hearts", "frame": 11 },
	"Kh": { "suit": "hearts", "frame": 12 },
	"Ac": { "suit": "clubs", "frame": 0 },
	"2c": { "suit": "clubs", "frame": 1 },
	"3c": { "suit": "clubs", "frame": 2 },
	"4c": { "suit": "clubs", "frame": 3 },
	"5c": { "suit": "clubs", "frame": 4 },
	"6c": { "suit": "clubs", "frame": 5 },
	"7c": { "suit": "clubs", "frame": 6 },
	"8c": { "suit": "clubs", "frame": 7 },
	"9c": { "suit": "clubs", "frame": 8 },
	"10c": { "suit": "clubs", "frame": 9 },
	"Jc": { "suit": "clubs", "frame": 10 },
	"Qc": { "suit": "clubs", "frame": 11 },
	"Kc": { "suit": "clubs", "frame": 12 },
	"Ad": { "suit": "diamonds", "frame": 0 },
	"2d": { "suit": "diamonds", "frame": 1 },
	"3d": { "suit": "diamonds", "frame": 2 },
	"4d": { "suit": "diamonds", "frame": 3 },
	"5d": { "suit": "diamonds", "frame": 4 },
	"6d": { "suit": "diamonds", "frame": 5 },
	"7d": { "suit": "diamonds", "frame": 6 },
	"8d": { "suit": "diamonds", "frame": 7 },
	"9d": { "suit": "diamonds", "frame": 8 },
	"10d": { "suit": "diamonds", "frame": 9 },
	"Jd": { "suit": "diamonds", "frame": 10 },
	"Qd": { "suit": "diamonds", "frame": 11 },
	"Kd": { "suit": "diamonds", "frame": 12 },
	"As": { "suit": "spades", "frame": 0 },
	"2s": { "suit": "spades", "frame": 1 },
	"3s": { "suit": "spades", "frame": 2 },
	"4s": { "suit": "spades", "frame": 3 },
	"5s": { "suit": "spades", "frame": 4 },
	"6s": { "suit": "spades", "frame": 5 },
	"7s": { "suit": "spades", "frame": 6 },
	"8s": { "suit": "spades", "frame": 7 },
	"9s": { "suit": "spades", "frame": 8 },
	"10s": { "suit": "spades", "frame": 9 },
	"Js": { "suit": "spades", "frame": 10 },
	"Qs": { "suit": "spades", "frame": 11 },
	"Ks": { "suit": "spades", "frame": 12 }
}


@export var _CardFace:String = "Ah"
@export var FaceUp:bool = true
var curCard = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	setCardFace(_CardFace)

func showCardFace():
	$AnimatedSprite2D.animation = CardFaceMap[_CardFace]["suit"]
	$AnimatedSprite2D.frame = CardFaceMap[_CardFace]["frame"]
	
func showCardBack():
	$AnimatedSprite2D.animation = "cardBack"
	$AnimatedSprite2D.frame = 1


func setCardFace(CardFace:String):
	_CardFace = CardFace
	if FaceUp:
		showCardFace()
	else:
		showCardBack()

	
func flipCard():
	FaceUp = !FaceUp
	if FaceUp:
		showCardFace()
	else:
		showCardBack()
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func nextCard():
	curCard += 1
	if curCard < len(CardFaceMap.keys()):
		setCardFace(CardFaceMap.keys()[curCard])
	else:
		curCard = 0
		setCardFace(CardFaceMap.keys()[curCard])


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flipCard()
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			nextCard()
