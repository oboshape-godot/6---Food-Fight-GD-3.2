extends CanvasLayer


#Personal Tutorials/Hints/Tips
#Loading a Texture... I wrote .texture(load("")) first which was wrong.
#butSym1.texture = load("res://Sprites/budAqueducts.png")



#The three buttons on which the symbols to choose from will appear
onready var butSym1 = get_node("TextureButton1")
onready var butSym2 = get_node("TextureButton2")
onready var butSym3 = get_node("TextureButton3")


var allArr
var comSymArr
var uncSymArr
var rarSymArr
var epiSymArr
var legSymArr
var speSymArr

var ranComSym
var ranUncSym
var ranRarSym
var ranEpiSym
var ranLegSym
var ranSpeSym

#Deletes this (ChooseSymbol)
func _deleteThis():
	queue_free()


#Function that chooses the symbol if space is available and
#sends the chosen symbol to the main slotmachine, saves it
#and lets the player place it on a slot.
func _on_TextureButton1_pressed():
	_deleteThis()

func _on_TextureButton2_pressed():
	_deleteThis()

func _on_TextureButton3_pressed():
	_deleteThis()

#When this node is ready we get the main array for
#all the symbols then sort those into the specific
#array variables we already prepared.
func _ready():
	_getMainArray()
	_arraySorting()
	_randomChanceCalculation()


func _randomChanceCalculation():
	var _rndNum1 = randi()%100+1
	var _rndNum2 = randi()%100+1
	var _rndNum3 = randi()%100+1
	_symbol1(_rndNum1)
	_symbol2(_rndNum2)
	_symbol3(_rndNum3)

func _symbol1(var _rnd):
	_randomSymbol()
	butSym1.add_child(_giveSymbol(_rnd))
	butSym1.get_child(0).position.x = 22
	butSym1.get_child(0).position.y = 22


func _symbol2(var _rnd):
	_randomSymbol()
	butSym2.add_child(_giveSymbol(_rnd))
	butSym2.get_child(0).position.x = 22
	butSym2.get_child(0).position.y = 22


func _symbol3(var _rnd):
	_randomSymbol()
	butSym3.add_child(_giveSymbol(_rnd))
	butSym3.get_child(0).position.x = 22
	butSym3.get_child(0).position.y = 22

func _giveSymbol(var _rnd):
	if _rnd <= 1:
		return(ranSpeSym)
	elif _rnd <= 3:
		return(ranLegSym)
	elif _rnd <= 7:
		return(ranEpiSym)
	elif _rnd <= 14:
		return(ranRarSym)
	elif _rnd <= 50:
		return(ranUncSym)
	elif _rnd <= 100:
		return(ranComSym)


func _getMainArray():
	var _symNod = get_parent().get_node("SymNod")
	allArr = _symNod.sendSymbolArray()

func _arraySorting():
	comSymArr = allArr[0]
	uncSymArr = allArr[1]
	rarSymArr = allArr[2]
	epiSymArr = allArr[3]
	legSymArr = allArr[4]
	speSymArr = allArr[5]

#The functions to pick a random symbol for each
#category.
func _randomSymbol():
	ranComSym = comSymArr[randi() % comSymArr.size()]
	ranUncSym = uncSymArr[randi() % uncSymArr.size()]
	ranRarSym = rarSymArr[randi() % rarSymArr.size()]
	ranEpiSym = epiSymArr[randi() % epiSymArr.size()]
	ranLegSym = legSymArr[randi() % legSymArr.size()]
	ranSpeSym = speSymArr[randi() % speSymArr.size()]
	



