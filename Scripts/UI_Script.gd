extends Control
const InitialRed : Color = Color(0.9, 0.4, 0.4, 1.0) 
const InitialGre : Color = Color(0.4, 0.9, 0.4, 1.0) 
const InitialBlu : Color = Color(0.4, 0.4, 0.9, 1.0) 
const InitialYel : Color = Color(0.9, 0.9, 0.4, 1.0) 
const InitialCya : Color = Color(0.4, 0.9, 0.9, 1.0) 
const InitialMag : Color = Color(0.9, 0.4, 0.9, 1.0) 
const InitialBla : Color = Color(0.4, 0.4, 0.4, 1.0) 
const InitialWhi : Color = Color(0.9, 0.9, 0.9, 1.0) 

@onready var initial_colours_array : Array = [InitialRed, InitialGre, InitialBlu, InitialYel, InitialCya, InitialMag, InitialBla, InitialWhi]

@onready var Red_Slider = $Sliders/Red
@onready var Gre_Slider = $Sliders/Gre
@onready var Blu_Slider = $Sliders/Blu
@onready var Yel_Slider = $Sliders/Yel
@onready var Cya_Slider = $Sliders/Cya
@onready var Mag_Slider = $Sliders/Mag
@onready var Bla_Slider = $Sliders/Bla
@onready var Whi_Slider = $Sliders/Whi

@onready var Btn_Reset = $Buttons/Btn_Reset
@onready var Btn_Random = $Buttons/Btn_Random
@onready var Btn_Shuffle = $Buttons/Btn_Shuffle_Colors

@onready var Btn_Palette = $Buttons/Btn_Palette
@onready var Pal_Slider = $Buttons/Pal
@onready var Btn_Paltze_Meth = $Buttons/Btn_Paltze_Meth

@onready var Btn_ColourReplaceFunction = $Buttons/Btn_ColourReplaceFunction

@onready var Btn_LoadFile = $Buttons/Btn_LoadFile
@onready var FD_LoadFile = $FD_LoadFile

@onready var Btn_SaveFile = $Buttons/Btn_SaveFile
@onready var sorry_bru = $Buttons/Dia_sorry_bru

@onready var DisplayedImage = $ImageControl/Image


func _ready() -> void:
	################################
	##    Load initial image      ##
	################################
	# we actually can't do this this way, since the path "res://Sprites/Beta.png" only exists before we package up this program. 
	# load_file_from_path("res://Sprites/Beta.png")
	################################
	##   Slickky Slicky Sliders   ##
	################################
	# Set Initial Slider Colours
	Red_Slider.color = InitialRed
	Pal_Slider.color = InitialRed
	Gre_Slider.color = InitialGre
	Blu_Slider.color = InitialBlu
	Yel_Slider.color = InitialYel
	Cya_Slider.color = InitialCya
	Mag_Slider.color = InitialMag
	Bla_Slider.color = InitialBla
	Whi_Slider.color = InitialWhi
	
	# Connect Each Slider to the appropriate function _on_XXX_color_changed
	Red_Slider.color_changed.connect(_on_red_color_changed)
	Gre_Slider.color_changed.connect(_on_gre_color_changed)
	Blu_Slider.color_changed.connect(_on_blu_color_changed)
	Yel_Slider.color_changed.connect(_on_yel_color_changed)
	Cya_Slider.color_changed.connect(_on_cya_color_changed)
	Mag_Slider.color_changed.connect(_on_mag_color_changed)
	Bla_Slider.color_changed.connect(_on_bla_color_changed)
	Whi_Slider.color_changed.connect(_on_whi_color_changed)
	#Initialize the shader replacement colour parameters - these are the default colours that the shader sets/converts the Utility Map to
	DisplayedImage.material.set_shader_parameter("ReplaceRed", Red_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceGre", Gre_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceBlu", Blu_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceYel", Yel_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceCya", Cya_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceMag", Mag_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceBla", Bla_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceWhi", Whi_Slider.color)
	
	################################
	## File Directory Shenanigans ##
	################################
	#Set initial Direcotry of File Loader
	FD_LoadFile.current_dir = "user://"
	# Connect Load Button to get_file_path -- which displays the File Dialoge and prompts for image file selection
	Btn_LoadFile.pressed.connect(get_file_path)
	# Connect file selection to load_file_from_path, which sets the selected image as the texture for DisplayedImage
	FD_LoadFile.file_selected.connect(load_file_from_path)
	# Connect the save button to a function that doesn't do anything right now
	Btn_SaveFile.pressed.connect(save_DisplayedImage_as_image)
	
	
	
	################################
	## Palettize a single colour  ##
	################################
	# Connect Palette Button to set_palette function
	# This is not yet implamented, the set_palette func currently does nothing ONE DAY
	
	Pal_Slider.color = InitialRed
	Btn_Palette.pressed.connect(set_palette)
	
	
	################################
	##  Colour Replace Dropdown   ##
	################################
	# Colour Replace Dropdown connects to set_ColourReplaceFunction in  Shader
	Btn_ColourReplaceFunction.item_selected.connect(set_ColourReplaceFunction)
	# initialize the Coulour Replace function to 0, which is the 8 sphere replace
	set_ColourReplaceFunction(0)
	
	################################
	##       Other buttons        ##
	################################
	# Connect Rest Button to rest function
	Btn_Reset.pressed.connect(reset)
	# Connect Random Button to set_random function
	Btn_Random.pressed.connect(set_random)
	# Connect Random Button to set_random function
	Btn_Shuffle.pressed.connect(shuffle_colors)



func _on_red_color_changed(color: Color) -> void:
	DisplayedImage.material.set_shader_parameter('ReplaceRed',color) 
func _on_gre_color_changed(color: Color) -> void:
	DisplayedImage.material.set_shader_parameter('ReplaceGre',color) 
func _on_blu_color_changed(color: Color) -> void:
	DisplayedImage.material.set_shader_parameter('ReplaceBlu',color) 
func _on_yel_color_changed(color: Color) -> void:
	DisplayedImage.material.set_shader_parameter('ReplaceYel',color) 
func _on_cya_color_changed(color: Color) -> void:
	DisplayedImage.material.set_shader_parameter('ReplaceCya',color) 
func _on_mag_color_changed(color: Color) -> void:
	DisplayedImage.material.set_shader_parameter('ReplaceMag',color) 
func _on_bla_color_changed(color: Color) -> void:
	DisplayedImage.material.set_shader_parameter('ReplaceBla',color) 
func _on_whi_color_changed(color: Color) -> void:
	DisplayedImage.material.set_shader_parameter('ReplaceWhi',color) 

func get_file_path() -> void:
	FD_LoadFile.popup_centered()

func load_file_from_path(path: String) -> void:
	print(path)
	var image = Image.load_from_file(path)

	if image:
		var texture = ImageTexture.create_from_image(image)# Convert the image data into a Texture
		DisplayedImage.texture = texture # Set the currently displayed image to the one selected from the file.
		print("Image loaded successfully from: ", path)
		var proportaions : Array = loop_over_image(image)
		print ("Random Color proportions: ", proportaions)

	else:
		print("Failed to load image from: ", path)
		
		
func loop_over_image(image : Image) -> Array:
	var y_max : int = image.get_height()
	var x_max : int = image.get_width()
	
	var color_proportions : Array = []
	
	for i in range(8): 
		color_proportions.append(0)
	for x in range(0,x_max,1):
		for y in range(y_max):
			#print(image.get_pixel(x,y).r)
			# calc distances
			# find color w min distance
			#0increment int in array associated with that color.
			#r0 g1 b2 y3 c4 m5 k6 w7
			#but actually just random for now
			var closest_color : int = randi() %8
			color_proportions[closest_color]=color_proportions[closest_color]+1

	var mag : int = 0
	for i in range(8): 
		mag = mag + color_proportions[i]

	for i in range(color_proportions.size()):
		# Divide the current element by the divisor and update it
		# GDScript handles integer division if the array is typed as int
		color_proportions[i] = color_proportions[i] / mag
	return color_proportions
	
func reset() -> void:
	################################
	##  Reset to Initial Colours  ##
	################################
	const set_colours_array : Array = [InitialRed, InitialGre, InitialBlu, InitialYel, InitialCya, InitialMag, InitialBla, InitialWhi]
	set_all_colours(set_colours_array)

func set_all_colours(set_colours_array : Array) -> void:
	Red_Slider.color = set_colours_array[0]
	Gre_Slider.color = set_colours_array[1]
	Blu_Slider.color = set_colours_array[2]
	Yel_Slider.color = set_colours_array[3]
	Cya_Slider.color = set_colours_array[4]
	Mag_Slider.color = set_colours_array[5]
	Bla_Slider.color = set_colours_array[6]
	Whi_Slider.color = set_colours_array[7]
	
	DisplayedImage.material.set_shader_parameter("ReplaceRed", Red_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceGre", Gre_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceBlu", Blu_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceYel", Yel_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceCya", Cya_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceMag", Mag_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceBla", Bla_Slider.color)
	DisplayedImage.material.set_shader_parameter("ReplaceWhi", Whi_Slider.color)

func set_palette() :
	################################
	##One Colour->8 Colour Palette##
	################################
	# index currently set to 0 by default, will later be a drop down that gives types of palettes. For now, monochrome only.
	var index : int =  Btn_Paltze_Meth.get_selected()
	var color : Color = Pal_Slider.get_pick_color()
	
	var palette_colors : Array = []
	#var colors: Array[Color] = []
	
	if index==0 : #monochromatic palette
		palette_colors = monochromatic_palette(color)
	if index == 1: #All One Colour
		for i in range(8): palette_colors.append(color)
	if index == 2: #Analagous Palette
		palette_colors = analagous_palette(color)
	if index == 3: #Complementary
		palette_colors = complementary_palette(color)
	if index == 4: #Split Complementary
		palette_colors = splitComplementary_palette(color)
	if index == 5: #Triadiac
		palette_colors = triadiac_palette(color)
	if index == 6: #Tetradic
		palette_colors = tetradic_palette(color)
	
	assert(len(palette_colors)==8)
	set_all_colours(palette_colors)
	
	

func monochromatic_palette(color : Color) -> Array:
	## Monochromatic. This Palette Takes the given clour and generates 8 evenly spaced colours
	# Get the base color's HSV components
	# Godot's Color class has h, s, v properties built-in (since at least Godot 3.2)
	var base_hue: float = color.h
	var base_saturation: float = color.s
	var colors : Array = []

	for i in range(8):
		# Generate a random 'value' (brightness/lightness) between 0.0 (black) and 1.0 (white)
		# Using randf() ensures a float value in the range [0.0, 1.0]
		var random_value: float = randf()

		# Create a new color using the base hue and saturation, but the random value
		var new_color: Color = Color.from_hsv(base_hue, base_saturation, random_value, color.a)
		
		colors.append(new_color)
	return colors

func analagous_palette(color : Color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#analagous
	var colors: Array[Color] = []
	# Provided colour is the Dominant Colour
	colors.append(color)
	# We want to grab the hue from it (hue is float ranging from 0 to 1, both of which are read) and ready a couple of copies of the og colour to have their hue modified slightly
	var base_hue: float = color.h
	var color_neighbor_1 : Color = color
	var color_neighbor_2: Color = color
	var color_neutral_0 : Color = color
	var color_neutralX_0 : Color = color
	var color_neutral_1 : Color = color
	var color_neutralX_1 : Color = color
	var color_neutral_2 : Color = color
	# the we want to grab a couple neighboring colours within .125 of the og hue (this is a quarter of the colour wheel, an eight to either side), making sure to mod it so it doesn't go over one. wrapf(hue_value, 0.0, 1.0)
	### create neighbor colour 1
	color_neighbor_1.h  = base_hue + wrapf(randf_range(-0.125,0.125), 0.0, 1.0)
	color_neutral_1 = color_neighbor_1
	colors.append(color_neighbor_1)
	
	### create neighbor colour 2
	color_neighbor_2.h  = wrapf(base_hue + randf_range(-0.125,0.125), 0.0, 1.0)
	color_neutral_2 = color_neighbor_2
	colors.append(color_neighbor_2)
	
	#make the rest of the colours neutral versions of the existing generated colours
	
	# dominant with low saturation
	#add two colours, dominant hue with 1/2 and 1/4 og saturation
	color_neutral_0.s = color.s/2
	colors.append(color_neutral_0)
	
	color_neutralX_0.s = color.s/4
	colors.append(color_neutral_0)
	
	#add two colours, neighbor 1 hue with 1/2 and 1/4 og saturation
	color_neutral_1.s = color_neighbor_1.s/2
	colors.append(color_neutral_1)
	
	color_neutralX_1.s = color_neighbor_1.s/4
	colors.append(color_neutral_1)
	
	#add one final colours, neighbor 2 hue with 1/2 og saturation
	color_neutral_2.s = color_neighbor_2.s/2
	colors.append(color_neutral_2)
	
	colors.shuffle()
	
	return colors

func complementary_palette(dominant : Color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#complementary_palette - new palette just dropped
	var colors: Array[Color] = []
	# Provided colour is the Dominant Colour
	colors.append(dominant)
	# We want to grab the hue from it (hue is float ranging from 0 to 1, both of which are read) and ready a couple of copies of the og colour to have their hue modified slightly
	var dominant_lowerV : Color = dominant
	var dominant_lowerS : Color = dominant
	
	var dominant_shade : Color = dominant
	var dominant_grey_highV_lowS : Color = dominant
	var dominant_grey_lowV_lowS : Color = dominant
	
	var complement_bright : Color = dominant
	var complement_dull : Color = dominant
	
	### create two harmonious colours 
	dominant_lowerV.v = dominant.v/2
	colors.append(dominant_lowerV)
	
	dominant_lowerS.s = dominant.s/2
	colors.append(dominant_lowerS)
	
	# Dark shade
	dominant_shade.s = clamp(dominant.s + (1-dominant.s)/2, 0.0, 1.0)
	dominant_shade.v = clamp(dominant.v/4, 0.0, 1.0)
	colors.append(dominant_shade)
	
	# Near white
	dominant_grey_highV_lowS.s = randf_range(0.00,0.1)
	dominant_grey_highV_lowS.v = randf_range(0.8,0.95)
	colors.append(dominant_grey_highV_lowS)
	
	# Near black
	dominant_grey_lowV_lowS.s = randf_range(0.05,0.2)
	dominant_grey_lowV_lowS.v = randf_range(0.05,0.2)
	colors.append(dominant_grey_lowV_lowS)
	
	
	### create complementary colour & a lower saturation/value version of it
	complement_bright.h  = wrapf(dominant.h + 0.5 + randf_range(-0.05,0.05), 0.0, 1.0)
	complement_bright.s  = dominant.s*randf_range(0.8,0.9)
	complement_bright.v  = dominant.v*randf_range(0.8,0.9)
	colors.append(complement_bright)
	
	### create a lower saturation/value version of the complement
	complement_dull = complement_bright
	complement_dull.s = complement_bright.s*randf_range(0.45,0.6)
	complement_dull.v = complement_bright.v*randf_range(0.45,0.6)
	colors.append(complement_dull)
	#colors.shuffle()
	
	return colors

func splitComplementary_palette(color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#Split Complementary
	var colors : Array = [Color(),color,Color(),Color(),Color(),Color(),Color(),Color()]
	return colors

func triadiac_palette(color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#Triadiac
	var colors : Array = [Color(),Color(),color,Color(),Color(),Color(),Color(),Color()]
	return colors

func tetradic_palette(color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#Tetradic
	var colors : Array = [Color(),Color(),Color(),color,Color(),Color(),Color(),Color()]
	return colors
	
func shuffle_colors() -> void:
	################################
	##Randomize Replacment Colours##
	################################
	#This function grabs all the current colours set in the colour sliders, then mixes them all up (by suffling, then calling the function which sets the sliders to the new colours and thereby updates the shader values)
	var set_colours_array : Array = []
	set_colours_array.append(Red_Slider.color)
	set_colours_array.append(Gre_Slider.color)
	set_colours_array.append(Blu_Slider.color)
	set_colours_array.append(Yel_Slider.color)
	set_colours_array.append(Cya_Slider.color)
	set_colours_array.append(Mag_Slider.color)
	set_colours_array.append(Bla_Slider.color)
	set_colours_array.append(Whi_Slider.color)
	set_colours_array.shuffle()
	set_all_colours(set_colours_array)

func set_random() -> void:
	################################
	##Randomize Replacment Colours##
	################################
	var set_colours_array : Array =[ Color(randf(), randf(),  randf(), 1.0), Color(randf(), randf(),randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0)]
	set_all_colours(set_colours_array)

func set_ColourReplaceFunction(index:int) -> void:
	################################
	##   Update Shader Function   ##
	################################
	DisplayedImage.material.set_shader_parameter("colour_replace_function", index)

func save_DisplayedImage_as_image() -> void:
	sorry_bru.popup_centered()
