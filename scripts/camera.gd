extends Camera2D

# Nodes that define the limits of the camera's movement
@onready var top_left =  $limit/top_left
@onready var bottom_right = $limit/bottom_right

# Previous mouse position, used for calculating how much to move the camera
var _previousPosition = Vector2(0,0)
# Camera postion when the mouse button was pressed
var _screen_start_position = Vector2(0,0)
# Scalar value for camera scrolling speed
var scroll_speed = 2

func _ready():
	# Initialize the camera movement limits
	limit_top = top_left.position.y
	limit_left = top_left.position.x
	limit_bottom = bottom_right.position.y
	limit_right = bottom_right.position.x
	
	# Enable input processing
	set_process_input(true)

func _unhandled_input(event):
	# If the left mouse button is pressed...
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			# Store the current mouse position and the camera's position
			_previousPosition = event.position
			_screen_start_position = position
			
			# Enable camera dragging
			Global.camera_drag = true
		else:
			# Disable camera dragging when the button is released
			Global.camera_drag = false
	# If the mouse is being moved and camera dragging is enabled...
	elif event is InputEventMouseMotion && Global.camera_drag:
		# Calculate the new camera position based on the mouse movement, the camera's zoom level, and the scroll_speed
		position.x = clamp((zoom * (scroll_speed * (_previousPosition - event.position)) + _screen_start_position).x, limit_left, limit_right)
		position.y = clamp((zoom * (scroll_speed * (_previousPosition - event.position)) + _screen_start_position).y, limit_top, limit_bottom)
