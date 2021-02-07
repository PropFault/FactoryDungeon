extends PipelineComponent
export(NodePath) var _socketA;
export(NodePath) var _socketB;
onready var socketA = get_node(_socketA);
onready var socketB = get_node(_socketB);

func processSocket(var liquidType, var socketA):
	if socketA.next != null and socketA.next.isPipe():
		var pipe = socketA.next as Pipe;
		if !pipe.fluids.has(liquidType.typeString):
			pipe.fluids[liquidType.typeString] = 0;
		pipe.fluids[liquidType.typeString] += liquidType.fluidProduced;
		if(!pipe.fluidTypes.has(liquidType.typeString)):
			pipe.fluidTypes[liquidType.typeString] = liquidType;

func _bodyInGrinder(var body : LiquidConvertible):
	var liquidType = body.convertToLiquidType();
	processSocket(liquidType, socketA);
	processSocket(liquidType, socketB);

func _process(delta):
	var socketAIT = socketA.next;
	var socketBIT = socketB.next;
	while(socketAIT != null):
		if(socketAIT.isPipe()):
			socketAIT.pumpingForce = 0.0;
		else:
			return;
		socketAIT = socketAIT.socket.next;
