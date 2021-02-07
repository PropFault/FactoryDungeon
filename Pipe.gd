extends PipelineComponent
class_name Pipe

export(NodePath)var _socket;
export(Font)var font;
export(float)var fillPercent;
onready var socket = get_node(_socket);


func _physics_process(delta):
	self.fillPercent = (self.volume/maxVolume) * 100.0;
	if socket.next != null and socket.next.isPipe():
		for fluid in fluids:
			if fluids[fluid] <=0:
				fluids.erase(fluid);
			else:
				if !socket.next.fluids.has(fluid):
					socket.next.fluids[fluid] = 0;
				if (socket.next.volume + fluids[fluid] * delta) < socket.next.maxVolume:
					var volumeToMove = fluids[fluid] * delta * 5.0;
					socket.next.fluids[fluid] += volumeToMove;
					fluids[fluid] -= volumeToMove;
				if !socket.next.fluidTypes.has(fluid):
					socket.next.fluidTypes[fluid] = fluidTypes[fluid];
	update()
func _draw():
	draw_string(font, Vector2(0,20),str(self.volume));

func isPipe():
	return true;
