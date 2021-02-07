extends PipelineComponent
class_name Pipe

export(NodePath)var _socket;
export(Font)var font;
export(float)var maxVolume = 100.0;
export(float)var fillPercent;
var volumeMass = 1.0;
var pumpingForce = 0.0
onready var forwardVec = Vector2()
onready var backwardVec = Vector2()
onready var socket = get_node(_socket);
var fluids:Dictionary;
var fluidTypes:Dictionary;
var volume:float setget _setVolume, getVolume;

func _setVolume(var volume):
	pass

func getVolume():
	var sum = 0;
	for type in fluids:
		sum += fluids[type];
	return sum;
func transferFluids(var pipe, var totalVolume):
	if(fluids.size() <=0):
		return;
	var fluidPerPart = totalVolume/fluids.size();
	var sizeLeft = fluids.size();
	for type in fluids:
		if fluids[type] >0:
			fluids[type] -= fluidPerPart;
			if !pipe.fluids.has(type):
				pipe.fluids[type] = 0;
			pipe.fluids[type] += fluidPerPart;
			sizeLeft -=1;
			if fluids[type] < 0:
				pipe.fluids[type] -= -fluids[type];
				transferFluids(pipe, -fluids[type]);

func _physics_process(delta):
	self.fillPercent = (self.volume/maxVolume) * 100.0;
	var localFWD = transform.x;
	forwardVec = (clamp(pumpingForce/volumeMass,0,self.volume) * localFWD).clamped(self.volume);
	backwardVec = Vector2();

	if(pumpingForce < 0.01):


		var gf = 9.81 * volume * volumeMass * 0.016;
		var pf = clamp(clamp(volume-maxVolume,0,self.volume) + delta*self.volume*self.volumeMass,0,self.volume);
		var dot = localFWD.dot(Vector2(0,1))
		var fdg = (dot * localFWD)
		var pressurised = (pf*fdg/2);
		var f = gf * fdg + pressurised ;
		forwardVec = Vector2();
		backwardVec = Vector2();
		pressurised = pressurised.clamped(self.volume);
		if(dot>0):
			forwardVec += f;
			backwardVec += pressurised
			forwardVec = forwardVec.clamped(self.volume - pressurised.length());
		if(dot<0):
			backwardVec += f;
			forwardVec += pressurised;
			backwardVec=backwardVec.clamped(self.volume - pressurised.length());
		else:
			forwardVec += pf*localFWD;
			backwardVec += pf*localFWD;
	var forwardVolume = clamp(forwardVec.length(),0,self.volume);
	var backwardVolume = clamp(backwardVec.length(),0,self.volume);
	if(self.socket.next !=null):
		if(self.socket.next.isPipe()):
			if not (self.socket.next.volume + forwardVolume) > self.socket.next.maxVolume:
				#self.socket.next.volume += fowardVolume;
				#self.volume -= fowardVolume;
				transferFluids(self.socket.next, forwardVolume);
	if(self.connectedSocket!=null and self.connectedSocket.socketOwner != null):
		if(self.connectedSocket.socketOwner.isPipe()):
			if not (self.connectedSocket.socketOwner.volume + backwardVolume) > self.connectedSocket.socketOwner.maxVolume:
				#self.connectedSocket.socketOwner.volume += backwardVolume;
				#self.volume -= backwardVolume;
				transferFluids(self.connectedSocket.socketOwner, backwardVolume);
	update()
func _draw():
	draw_string(font, Vector2(0,20),str(self.volume));
	draw_line(Vector2(), transform.basis_xform_inv(forwardVec),Color.red);
	draw_line(Vector2(), transform.basis_xform_inv(backwardVec),Color.blue);
	
func isPipe():
	return true;
