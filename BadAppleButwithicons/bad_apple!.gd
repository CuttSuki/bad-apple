extends Node2D
var width = 167
var height = 100

var timesince:float = 0
var icon = preload("res://icon.svg")
var array:Array = []
var framesRendered:int = 0
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$VideoStreamPlayer.play()
	for x in range(width/2):
		array.append([])
		for y in range(height/2):
			var sprite = Sprite2D.new()
			sprite.texture = icon
			sprite.scale = Vector2(0.2, 0.2)
			add_child(sprite)
			sprite.offset = Vector2(x * 20, y *20)
			sprite.position += Vector2(x * 20,y *20)
			array[x].append(sprite)
			
	#$VideoStreamPlayer.play()
	
func _physics_process(delta):
	
		var texture = $VideoStreamPlayer.get_video_texture()
		var image: Image = texture.get_image()
		if image !=null:
			framesRendered +=1
			self.get_node("Frames Rendered").text = "Frames Rendered :" + str(framesRendered)
			self.get_node("FPS").text = "FPS :" + str(Engine.get_frames_per_second())
			image.resize(width/2,height/2,1)
			for x in range(width/2):
				for y in range(height/2):
					var pixelValue = image.get_pixel(x,y).r
					array[x][y].modulate = Color(pixelValue,pixelValue,pixelValue,1)
					



func _on_video_stream_player_finished():
	get_tree().quit()
