extends PipelineComponent
class_name Pipe

export(NodePath)var _socket;
export(Font)var font;
export(float)var volume;
export(float)var maxVolume = 100.0;
export(float)var fillPercent;
export(float)var volumeMass = 1.0;
var pumpingForce = 0.0
onready var forwardVec = Vector2()
onready var backwardVec = Vector2()
onready var socket = get_node(_socket);



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
	var fowardVolume = clamp(forwardVec.length(),0,self.volume);
	var backwardVolume = clamp(backwardVec.length(),0,self.volume);
	if(self.socket.next !=null):
		if not (self.socket.next.volume + fowardVolume) > self.socket.next.maxVolume:
			self.socket.next.volume += fowardVolume;
			self.volume -= fowardVolume;
	if(self.connectedSocket!=null and self.connectedSocket.socketOwner != null):
		if not (self.connectedSocket.socketOwner.volume + fowardVolume) > self.connectedSocket.socketOwner.maxVolume:
			self.connectedSocket.socketOwner.volume += backwardVolume;
			self.volume -= backwardVolume;
	update()
func _draw():
	draw_string(font, Vector2(0,20),str(self.volume));
	draw_line(Vector2(), transform.basis_xform_inv(forwardVec),Color.red);
	draw_line(Vector2(), transform.basis_xform_inv(backwardVec),Color.blue);
	
func isPipe():
	return true;
