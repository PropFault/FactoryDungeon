extends Resource
class_name LiquidType
var solidPacked:PackedScene;
var color:Color;
var fluidProduced;
var typeString;

func _init(var solidRoot,var solidSprite, var ts, var fluidProduced):
	self.typeString = ts;
	self.fluidProduced = fluidProduced;
	self.solidPacked = PackedScene.new();
	self.solidPacked.pack(solidRoot.get_tree().get_current_scene());
	yield(solidSprite.texture, "changed")
	var image = solidSprite.texture.get_data();
	var avgR = 0.0;
	var avgG = 0.0;
	var avgB = 0.0;
	var pixelC = 0;
	for x in range(0, image.get_width()):
		for y in range(0, image.get_height()):
			var pixel = image.get_pixel(x,y);
			avgR += pixel.r;
			avgG += pixel.g;
			avgB += pixel.b;
			pixelC+=1;
	
	avgR /= pixelC;
	avgG /= pixelC;
	avgB /= pixelC;
	
	self.color = Color(avgR, avgG, avgB);
