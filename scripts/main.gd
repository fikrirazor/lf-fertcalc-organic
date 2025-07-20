extends Control

@export var initialPage := 0

@onready var pages: MarginContainer = %Pages
@onready var buttons: HBoxContainer = %Buttons
@onready var home_button = %HomeButton
@onready var about_button = %AboutButton

func _ready():
	_set_page(initialPage)
	
	home_button.pressed.connect(_set_page.bind(0))
	about_button.pressed.connect(_set_page.bind(1))

func _set_page(pageNumber):
	for i in pages.get_child_count():
		pages.get_children()[i].visible = (i == pageNumber)
