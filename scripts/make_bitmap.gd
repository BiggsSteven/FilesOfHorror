extends TextureButton

func _ready() -> void:
	var BaseImage: Image
	BaseImage = texture_normal.get_image()
	var newBitMap = BitMap.new()
	newBitMap.create_from_image_alpha(BaseImage,0.2)
	texture_click_mask = newBitMap
