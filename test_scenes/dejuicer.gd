extends PipelineComponent
export(float, 0.01, 999.9)var spawnRate;
var timer = 0.0;

func _ready():
	pass # Replace with function body.

func _process(delta):
	if timer > spawnRate:
		for fluid in fluids:
			var type = fluidTypes[fluid];
			if fluids[fluid] >= (type.fluidProduced-0.00001):
				fluids[fluid] -= type.fluidProduced;
				var newSolid = type.solidPacked.instance();
				newSolid.global_position = self.global_position;
				type.parent.add_child(newSolid)
			print(fluids[fluid], " >= ", type.fluidProduced);
		timer = 0;
	timer += delta;

func isPipe():
	return true;
