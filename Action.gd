class_name Action
var timeStart;
var timeEnd;
var target;
var goalPosition;
var goalRotation;
var goalScale;
var interp;
var goalInterp;
var startPosition;
var runningPosition;
var init;

	
func _init(timeStart, timeEnd, startInterp, goalInterp, target, goalPosition = Vector3(0,0,0), goalRotation = Vector3(0,0,0), goalScale = Vector3(0,0,0)):
	self.timeStart = timeStart;
	self.timeEnd = timeEnd;
	self.interp = startInterp;
	self.goalInterp = goalInterp;
	self.target = target;
	self.goalPosition = goalPosition;
	self.goalRotation = goalRotation;
	self.goalScale = goalScale;
	self.init = false;

func update(delta):
	if self.init == false:
		self.startPosition = self.target.transform.origin;
		self.runningPosition = self.startPosition;
		self.init = true;
	if self.interp > self.goalInterp:
		self.init = false;
		return;


	self.interp += delta / (timeEnd - timeStart);
	var op = self.runningPosition;
	runningPosition = self.startPosition.linear_interpolate(self.goalPosition, self.interp);
	
	self.target.transform.origin += self.runningPosition - op;
