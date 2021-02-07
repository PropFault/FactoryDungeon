extends PipelineComponent
export(NodePath) var _socketA;
export(NodePath) var _socketB;
onready var socketA = get_node(_socketA);
onready var socketB = get_node(_socketB);

func processSocket(var liquidType, var socketA, var ratio):
	if socketA.next != null and socketA.next.isPipe():
		var pipe = socketA.next as Pipe;
		if !pipe.fluids.has(liquidType.typeString):
			pipe.fluids[liquidType.typeString] = 0;
		pipe.fluids[liquidType.typeString] += liquidType.fluidProduced*ratio;
		if(!pipe.fluidTypes.has(liquidType.typeString)):
			pipe.fluidTypes[liquidType.typeString] = liquidType;

func _bodyInGrinder(var body : LiquidConvertible):
	if(body == null):
		print("LMAO");
		return;
	var liquidType = body.convertToLiquidType();
	var ratio = 0;
	if socketA.next != null and socketA.next.isPipe():
		ratio += 1;
	if socketB.next != null and socketB.next.isPipe():
		ratio += 1;
	print(1.0/ratio)
	processSocket(liquidType, socketA, 1.0/ratio);
	processSocket(liquidType, socketB, 1.0/ratio);

